import 'package:flutter/cupertino.dart';

import '../base/constants/app_constants.dart';
import 'nonnullable_text.dart';

class TextContainerWidget extends StatelessWidget {
  final String? text;
  const TextContainerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColorConstants.authColor,
borderRadius: BorderRadius.circular(AppBorderRadiusConstants.miniRadius),
        border: const Border.fromBorderSide(BorderSide.none)
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: NonnullableText(
        text: text,
        textStyle: AppTextStyleConstants.appBarTextStyle.copyWith(color: AppColorConstants.whiteColor),
      ),
    );
  }
}
