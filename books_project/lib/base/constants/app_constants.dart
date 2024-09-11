import 'package:flutter/material.dart';

class AppColorConstants {
  static const Color shadowColor = Colors.blueGrey;
  static const Color scafoldBackGroundColor = Colors.blueGrey;
  static const Color cardColor = Colors.white70;
  static const Color containerColor = Color(0xffF2F1EE);
  static  Color appBarColor = Colors.white70.withOpacity(0.1);
  static const Color authColor = Color(0xff363329);
  static const Color chipColor = Color(0xff363A44);
  static const Color whiteColor = Color(0xffffffff);
  static const Color blackColor = Color(0xf0000000);
  static const Color redColor = Color(0xffE52613);
  static const Color ligtGreyColor = Color(0xffDEE3E2);
}

class AppFontSizeConstants {
  static const double miniSize = 12;
  static const double mediumSize = 18;
  static const double largeSize = 20;
  static const double veryLargeSize = 25;
}

class AppFontWeightConstants {
  static const FontWeight normal = FontWeight.normal;
  static const FontWeight bold = FontWeight.bold;
}

class AppEdgeInsetsConstants {
  static const double veryMiniPadding = 4;
  static const double miniPadding = 8;
  static const double mediumPadding = 16;
  static const double largePadding = 24;
  static const double veryLargePadding = 32;
}

class AppBorderRadiusConstants {
  static const double veryMiniRadius = 4;
  static const double miniRadius = 7;
  static const double mediumRadius = 14;
  static const double largeRadius = 21;
  static const double veryLargeRadius = 28;
  static const double veryXLargeRadius = 50;

}

class AppTextStyleConstants {
  static const TextStyle authButtonTextStyle =
  TextStyle(color: AppColorConstants.whiteColor, fontSize: AppFontSizeConstants.mediumSize, fontWeight: AppFontWeightConstants.bold);

  static const TextStyle appBarTextStyle =
  TextStyle( fontSize: AppFontSizeConstants.largeSize, fontWeight: AppFontWeightConstants.bold);


  static const TextStyle normalTextStyle = TextStyle(fontSize: AppFontSizeConstants.mediumSize);

}

class LocaleConstants {
  static const trLocale = Locale("tr", "TR");
  static const enLocale = Locale("en", "US");


  static const eyePath = "assets/images/eyes.png";
  static const localPath = "assets/translations";
  static const apiKey = '2Vf7L5BMgVmXLYvNdXblMC:1Yg7hh7UjZ7OtygVQWd6mf';

  static const networkImageUrl = "https://firebasestorage.googleapis.com/v0/b/firestore-uygulamalari.appspot.com/o/placheholder.png?alt=media&token=73b4585d-2129-437c-aaee-ad2ecacd3797";
  static const localImageUrl = "assets/images/placheholder.png";



}
