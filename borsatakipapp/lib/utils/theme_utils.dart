import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';

var theme = ThemeData(
    scaffoldBackgroundColor: AppColorConstants.scafoldBackGroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              AppBorderRadiusConstants.mediumRadius,
            )),
            backgroundColor: AppColorConstants.chipColor,
            textStyle: const TextStyle(
              color: AppColorConstants.whiteColor,
              fontSize: 16,
              fontWeight: AppFontWeightConstants.bold,
            ))),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColorConstants.appBarColor,
    titleTextStyle: AppTextStyleConstants.appBarTextStyle,

  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: AppColorConstants.authColor,size: 30),
    backgroundColor: AppColorConstants.appBarColor,

  ),
iconTheme: const IconThemeData(color: AppColorConstants.whiteColor,size: 30,),

buttonTheme: ButtonThemeData(buttonColor:AppColorConstants.scafoldBackGroundColor.withOpacity(0.5),)


);
