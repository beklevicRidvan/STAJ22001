// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "emailHint": "Email",
  "passwordHint": "Password",
  "login": "Login",
  "isntAccount": "don't you have an account",
  "signUp": "Sign up",
  "fullName": "Fullname",
  "aPassword": "Confirm password",
  "isAccount": "do you have an account"
};
static const Map<String,dynamic> tr_TR = {
  "emailHint": "E-posta",
  "passwordHint": "Şifre",
  "login": "Giriş yap",
  "isntAccount": "Hesabın mı Yok?",
  "signUp": "Kayıt ol",
  "fullName": "Ad Soyad",
  "aPassword": "Parolayı onaylayın",
  "isAccount": "Hesabın Var mı?"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US, "tr_TR": tr_TR};
}
