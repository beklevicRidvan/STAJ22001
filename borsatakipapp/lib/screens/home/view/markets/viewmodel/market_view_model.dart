import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:flutter_fake_api/components/alert_dialog.dart';
import 'package:flutter_fake_api/screens/home/view/markets/market_service.dart';
import 'package:flutter_fake_api/translations/locale_keys.g.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';

import '../../../../../models/money_model.dart';

class MarketViewModel extends BaseViewModel {
  String type;
  final MarketService service;
  double _priceValue = 0;
  final TextEditingController _balanceController = TextEditingController();
  MarketViewModel({required this.service, required this.type});
  late int followedListLength = 0;

  @override
  FutureOr<void> init() async {
    await fetchDatas();
    await fetchFollowedListLength();
  }

  Future<void> fetchDatas() async {
    isLoading = true;

    try {
      var response = await service.fetchDatas(type);

      if (response.isSucces) {
        //String updatedTime = response.data['result']['lastupdate'];
/*
      if (response.data['response']['data'] is List) {
        var data = response.data['result']['data'] as List;
        try {
          _moneys = data.map((e) => MoneyModel.fromMap(e, updatedTime)).toList();
        } catch (e) {
          debugPrint('Data mapping error: $e');
        }
      } else {
        debugPrint('Unexpected data format');
      }
    } else {
      debugPrint('Fetch data failed');
    }

 */

        _moneys = response.data;
      } else {
        debugPrint(response.errorMessage.toString());
      }
    } catch (r) {
      debugPrint(r.toString());
    } finally {
      isLoading = false;
    }
  }

  Future<void> depositMoney(BuildContext context) async {
    isLoading = true;
    if (_priceValue < 0) {
      throw Exception("Para 0 dan büyük olmalı");
    }
    try {
      var response = await service.updateBalanceValue(_priceValue, true);
      SharedPreferencesUtil().setBalance(_priceValue + SharedPreferencesUtil().getBalance()!);
      reloadState();

      showMyDialog(context, response.errorMessage);
    } catch (e) {
      showMyDialog(context, e.toString());
    } finally {
      isLoading = false;
    }
  }

  void increaseBalance(double amount) {
    _balanceController.text = _priceValue.toString();
    _priceValue += amount;
    reloadState();
  }

  void decreaseBalance(double amount) {
    if (_priceValue - amount >= 0) {
      _balanceController.text = _priceValue.toString();

      _priceValue -= amount;
      reloadState();
    }
  }

  Future<void> fetchFollowedListLength() async {
    isLoading = true;
    try {
      followedListLength = await service.getFollowedByListLength();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void reloadData() async {
    await fetchFollowedListLength();
    reloadState();
  }

  Future<void> withDrawMoney(BuildContext context) async {
    if (_priceValue > 0) {
      isLoading = true;
      var response = await service.updateBalanceValue(_priceValue, false);
      SharedPreferencesUtil().setBalance(SharedPreferencesUtil().getBalance()! - _priceValue);
      reloadState();
      isLoading = false;
      showMyDialog(context, response.errorMessage);
    } else {
      showMyDialog(context, LocaleKeys.progressNotSuccess);
    }
  }

  List<MoneyModel> _moneys = [];

  double get priceValue => _priceValue;

  set priceValue(double value) {
    _priceValue = value;
    reloadState();
  }

  List<MoneyModel> get moneys => _moneys;

  TextEditingController get balanceController => _balanceController;
}
