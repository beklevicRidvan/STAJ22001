import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../base/constants/app_constants.dart';
import '../../base/enums/language_type_enum.dart';
import '../../base/viewmodels/base_view_model.dart';
import '../sharred_preferences_utils.dart';

class AppLanguage extends BaseViewModel {
  final BuildContext context;
  String? _language = LanguagesType.EN.name;

  AppLanguage(this.context);

  @override
  FutureOr<void> init() async {
    reloadState();
    final String defaultLocale = Platform.localeName;
        LanguagesType.values.firstWhereOrNull((l) => defaultLocale.contains(l.name))?.name ??
        LanguagesType.EN.name;
    setLocaleLanguage(_language, context);

  }

  Future<void> changeLanguage(String? lang, BuildContext context) async {
    try {
      setLocaleLanguage(lang, context);

      _language = lang ?? LanguagesType.EN.name;
    } catch (e) {
      _language = LanguagesType.EN.name;
    } finally {
      reloadState();
    }
  }

  void setLocaleLanguage(String? lang, BuildContext context) {
    if (lang == LanguagesType.TR.name){
      context.setLocale(LocaleConstants.trLocale);

    }

    else if (lang == LanguagesType.EN.name){
      context.setLocale(LocaleConstants.enLocale);

    }
  }

  static getLanguage() {
    var lang = SharedPreferencesUtil().getLocale();
    if (lang == LanguagesType.TR.name)
      return LocaleConstants.trLocale.toStringWithSeparator(separator: "-");
    else if (lang == LanguagesType.EN.name)
      return LocaleConstants.enLocale.toStringWithSeparator(separator: "-");
    else
      return LocaleConstants.trLocale.toStringWithSeparator(separator: "-");
  }

  //getters
  String? get language => _language;
}
