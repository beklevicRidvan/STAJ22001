import 'package:flutter/material.dart';

import '../base/constants/app_constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscureValue;
  final bool isPassword;
  final String? hintText;
  final void Function()?  onPressed;
  final  void Function(String)? onChanged;
  const MyTextField({super.key, required this.controller, this.isObscureValue = false, this.hintText, this.onPressed, this.isPassword = false,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: AppColorConstants.chipColor, spreadRadius: 0.8, blurRadius: 16, offset:  Offset(0, 5))]),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: isObscureValue,
        cursorColor: AppColorConstants.blackColor,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            suffixIcon: isPassword
                ? IconButton(onPressed: onPressed, icon: isObscureValue ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))
                : const SizedBox.shrink(),
            fillColor: AppColorConstants.whiteColor,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppBorderRadiusConstants.largeRadius), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadiusConstants.largeRadius),
                borderSide: const BorderSide(color: AppColorConstants.authColor))),
      ),
    );
  }
}