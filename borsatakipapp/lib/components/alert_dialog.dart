import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';

void showMyDialog(BuildContext context,String message){
  showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: AppColorConstants.appBarColor,title: Text(message,style: AppTextStyleConstants.appBarTextStyle,),),);
}