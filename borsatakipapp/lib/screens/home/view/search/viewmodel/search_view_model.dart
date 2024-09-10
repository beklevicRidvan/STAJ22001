import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:flutter_fake_api/screens/home/view/search/search_service.dart';

import '../../../../../models/crypto_model.dart';

class SearchViewModel extends BaseViewModel {
  final SearchService service;
  TextEditingController searchingController = TextEditingController();
  List<CryptoModel> _cryptos = [];
  List<CryptoModel> _oldCryptos = []; // Eski veriler burada saklanacak
  bool _isVisible = false;

  @override
  FutureOr<void> init() async {
    await getDatas();
  }
  SearchViewModel({required this.service});

  List<CryptoModel> get cryptos => _cryptos;
  bool get isVisible => _isVisible;

  set isVisible(bool value) {
    _isVisible = value;
    reloadState();
  }

  Future<void> getDatas() async {
    isLoading = true;
    reloadState();

    var response = await service.getCoinsDatas();
    if (response.isSucces) {
      var datas = response.data as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
      _oldCryptos = datas.map((e) => CryptoModel.fromMap(e.data())).toList();

      final searchQuery = searchingController.text.toLowerCase();
      if (searchQuery.isEmpty) {
        _cryptos = _oldCryptos;
      } else {
        final uniqueUsers = Set<CryptoModel>.from(
          _oldCryptos.where((element) {
            final lowerCaseUserName = element.coinName.toLowerCase();
            return lowerCaseUserName.contains(searchQuery);
          }),
        );
        _cryptos = uniqueUsers.toList();
      }

      reloadState();
    }

    isLoading = false;
    reloadState();
  }

  void clearSearch() {
    searchingController.clear();
    _cryptos = _oldCryptos; // Eski verileri geri yükle
    reloadState();
  }


}
