import 'package:flutter/material.dart';

import '../base/constants/app_constants.dart';

class MyAuthButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyAuthButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,

        padding: const EdgeInsets.all( AppEdgeInsetsConstants.mediumPadding),
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadiusConstants.largeRadius),
            color: AppColorConstants.authColor,
            boxShadow: const [BoxShadow(color: AppColorConstants.blackColor, spreadRadius: 0.8, blurRadius: 7, offset: Offset(0, 5))]),
        child: Text(text,style: AppTextStyleConstants.authButtonTextStyle,),
      ),
    );
  }
}