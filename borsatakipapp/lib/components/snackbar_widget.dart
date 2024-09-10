import 'package:flutter/material.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

import '../translations/locale_keys.g.dart';

void showSnackBar(BuildContext context,String warningMessage,Function() func){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(warningMessage),
      duration:const Duration(seconds: 2), // Snackbar'ın ekranda kalma süresi
      action: SnackBarAction(label: LocaleKeys.yes.locale, onPressed: func)
    ),
  );
}