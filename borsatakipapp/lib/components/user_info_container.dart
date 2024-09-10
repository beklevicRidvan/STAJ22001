import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';
import 'package:flutter_fake_api/components/image_customize_widget.dart';
import 'package:flutter_fake_api/components/nonnullable_text.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

class UserInfoContainer extends StatelessWidget {
  final String? imgUrl;
  final String? userName;
  final String? userEmail;
  const UserInfoContainer({super.key, required this.imgUrl, required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColorConstants.containerColor,
          borderRadius: BorderRadius.circular(AppBorderRadiusConstants.miniRadius),
          border: const Border.fromBorderSide(BorderSide.none)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        ImageCustomizeWidget(imgUrl: imgUrl),
          SizedBox(width: context.getDeviceWidth()*0.01,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NonnullableText(
                text: userEmail,

              ),
              SizedBox(height: context.getDeviceHeigth()*0.01,),
              NonnullableText(
                text: userName,
                textStyle: AppTextStyleConstants.appBarTextStyle.copyWith(fontSize: 16,fontWeight: FontWeight.normal),
              )
            ],
          )
        ],
      ),
    );
  }
}
