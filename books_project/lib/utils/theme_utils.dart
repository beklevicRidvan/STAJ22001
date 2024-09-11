import 'package:flutter/material.dart';

import '../base/constants/app_constants.dart';

var theme = ThemeData(
    scaffoldBackgroundColor: AppColorConstants.scafoldBackGroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: AppColorConstants.chipColor,
            textStyle: const TextStyle(
              color: AppColorConstants.whiteColor,
              fontSize: 16,
            ))),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorConstants.appBarColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: const IconThemeData(color: AppColorConstants.whiteColor),
      backgroundColor: AppColorConstants.appBarColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColorConstants.whiteColor,
      size: 30,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColorConstants.scafoldBackGroundColor.withOpacity(0.5),
    ));
