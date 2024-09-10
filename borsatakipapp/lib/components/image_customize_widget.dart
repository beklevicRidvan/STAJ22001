import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

import '../base/constants/app_constants.dart';

class ImageCustomizeWidget extends StatelessWidget {
  final double value;
  final String? imgUrl;
  const ImageCustomizeWidget({super.key,required this.imgUrl,this.value = 0.1});

  @override
  Widget build(BuildContext context) {
    return   Image(
      image: imgUrl == null ? const AssetImage(LocaleConstants.localImageUrl) : NetworkImage(imgUrl!),
      loadingBuilder: (context, child, loadingProgress) {
        if(loadingProgress == null) return child;
        return CircularProgressIndicator.adaptive(
          backgroundColor: AppColorConstants.chipColor,
        );
      },
      fit: BoxFit.contain,

      //errorBuilder: (context, error, stackTrace) => const Icon(Icons.warning_amber),
      height: context.getDeviceHeigth() * value,
    );
  }
}
