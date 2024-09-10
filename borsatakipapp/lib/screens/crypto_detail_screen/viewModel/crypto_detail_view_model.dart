import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:flutter_fake_api/models/crypto_model.dart';
import 'package:flutter_fake_api/screens/crypto_detail_screen/crypto_detail_service.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';

import '../../../components/alert_dialog.dart';

class CryptoDetailViewModel extends BaseViewModel {
  CryptoModel cryptoModel;
  double _priceValue = 1;
  final CryptoDetailService service;
  late bool _isFavorited;
  final TextEditingController _balanceController = TextEditingController();

  CryptoDetailViewModel({required this.service, required this.cryptoModel});

  @override
  FutureOr<void> init() async {
    // TODO: implement init
    _balanceController.text = cryptoModel.price.toString();
    await isFavoritedValue();
  }

  void increaseBalance(double amount) {
    _priceValue += amount;

    _balanceController.text = (_priceValue * cryptoModel.price).toString();

    reloadState();
  }

  void decreaseBalance(double amount) {
    if (_priceValue - amount >= 0) {
      _priceValue -= amount;
      _balanceController.text = (_priceValue * cryptoModel.price).toString();

      reloadState();
    }
  }

  Future<void> addFavoritesForCrypto(BuildContext context) async {
    isLoading = true;
    try {
      await service.addFavorites(cryptoModel);
      isFavoritedMethod();
    } catch (e) {
      showMyDialog(context, e.toString());
    } finally {
      isLoading = false;
    }
  }

  void isFavoritedMethod() async {
    _isFavorited = await service.isFavorited(cryptoModel);
    reloadState();
  }

  Future<void> deleteFavoritesCryptoByUser(BuildContext context) async {
    isLoading = true;
    try {
      await service.deleteFavorites(cryptoModel);
      isFavoritedMethod();
    } catch (e) {
      showMyDialog(context, e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<void> isFavoritedValue() async {
    isFavorited = await service.isFavorited(cryptoModel);
  }

  Future<bool> addCryptosForCrypto(BuildContext context) async {
    isLoading = true;
    try {
      await service.addMyCryptos(cryptoModel, _priceValue);
      if (SharedPreferencesUtil().getBalance()! > cryptoModel.price * _priceValue) {
        SharedPreferencesUtil().setBalance(SharedPreferencesUtil().getBalance()! - cryptoModel.price * _priceValue);
      }
      return true;
    } catch (e) {

      showMyDialog(context, e.toString());
      return false;
    } finally {
      isLoading = false;
    }
  }

  set priceValue(double value) {
    _priceValue = value;
    reloadState();
  }

  set isFavorited(bool value) {
    _isFavorited = value;
    reloadState();
  }

  double get price => _priceValue;

  bool get isFavorited => _isFavorited;

  double get priceValue => _priceValue;

  TextEditingController get balanceController => _balanceController;
}
