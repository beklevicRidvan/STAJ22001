import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


extension UsefulMethods on BuildContext{
  double getDeviceHeigth()=> MediaQuery.of(this).size.height;
  double getDeviceWidth()=> MediaQuery.of(this).size.width;

}
extension StringLocalization on String {
  String get locale => this.tr().toString();
}
