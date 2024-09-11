import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../base/viewmodels/base_view_model.dart';
import '../service/home_service.dart';

//flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

class HomeViewModel extends BaseViewModel {
  int _selectedIndex = 0;
  String? fullName;
  String? email;
  final HomeService service;
  final PageController _pageController = PageController(initialPage: 0);

  HomeViewModel({required this.service});

  void changePage(int value) {
    selectedIndex = value;
    _pageController.jumpToPage(selectedIndex);
    reloadState();
  }

  @override
  FutureOr<void> init() async {
    isLoading = true;
    const Duration(seconds: 2);
    isLoading = false;
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    reloadState();
  }

  int get selectedIndex => _selectedIndex;

  get pageController => _pageController;
}
