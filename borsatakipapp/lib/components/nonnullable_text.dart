import "package:flutter/material.dart";
class NonnullableText extends StatelessWidget {
  final TextStyle? textStyle;
  final String? text;
  const NonnullableText({super.key,this.textStyle,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "null",
      style: textStyle,
    );
  }
}
