import 'package:flutter/material.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

import '../base/constants/app_constants.dart';
import '../models/crypto_model.dart';
import '../utils/navigation_utils.dart';
import 'image_customize_widget.dart';

class BuildListItem extends StatelessWidget {
  final CryptoModel currentElement;
  final bool isFollowedPage;
  final Function()? deleteFunc;

  const BuildListItem({super.key, required this.currentElement,this.isFollowedPage=false,this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColorConstants.appBarColor.withOpacity(0.4),
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(AppBorderRadiusConstants.veryLargeRadius),
            child: ImageCustomizeWidget(
              imgUrl: currentElement.iconUrl,
              value: 0.06,
            )),
        title: Text(currentElement.coinCode),
        subtitle: Text(currentElement.coinName),
        trailing: isFollowedPage ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildContainer(context),
            IconButton(onPressed: deleteFunc, icon: const Icon(Icons.delete_forever))
          ],
        ) : buildContainer(context),
        onTap: () => NavigationUtils.navigateToCryptoDetailScreen(context, currentElement),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
          width: context.getDeviceHeigth() * 0.13,
          decoration: BoxDecoration(border: Border.all(color: AppColorConstants.blackColor)),
          alignment: Alignment.center,
          child: Text(
            currentElement.price.toStringAsFixed(3),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ));
  }
}