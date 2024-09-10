import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  final bool isAutomaticlyLeading;
  final List<Widget>? actions;

  const AppbarWidget({super.key,required this.title,this.isAutomaticlyLeading=false,this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: AppTextStyleConstants.appBarTextStyle,),
      automaticallyImplyLeading: isAutomaticlyLeading,
      actions: actions,
      backgroundColor: AppColorConstants.appBarColor,
    );
  }
}
