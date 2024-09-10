import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';
import 'package:flutter_fake_api/components/appbar_widget.dart';
import 'package:flutter_fake_api/components/image_customize_widget.dart';
import 'package:flutter_fake_api/components/my_authbutton.dart';
import 'package:flutter_fake_api/components/my_text_field.dart';
import 'package:flutter_fake_api/components/text_container_widget.dart';
import 'package:flutter_fake_api/screens/profile_settings/view_model/profile_settings_view_model.dart';
import 'package:flutter_fake_api/translations/locale_keys.g.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsView extends StatelessWidget {
  final ProfileSettingsScreenViewModel viewModel;
  const ProfileSettingsView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(
          title: LocaleKeys.profileSettingsAppBar.locale,
          isAutomaticlyLeading: true,
        ),
        SizedBox(
          height: context.getDeviceHeigth() * 0.02,
        ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadiusConstants.miniRadius),
              child: ImageCustomizeWidget(
                imgUrl: SharedPreferencesUtil().getImage(),
                value: 0.3,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      decoration: const BoxDecoration(
                          color: AppColorConstants.containerColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(AppBorderRadiusConstants.mediumRadius),
                              topLeft: Radius.circular(AppBorderRadiusConstants.mediumRadius))),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDialogRow(LocaleKeys.takePictureWithCamera.locale, const Icon(Icons.camera_alt_outlined),
                              () async => await viewModel.takeAPicture(ImageSource.camera, context), context),
                          SizedBox(height: context.getDeviceHeigth() * 0.01),
                          _buildDialogRow(LocaleKeys.takePictureWith.locale, const Icon(Icons.photo_outlined),
                              () async => await viewModel.takeAPicture(ImageSource.gallery, context), context),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorConstants.chipColor),
                    child: const Icon(
                      Icons.camera,
                      size: 20,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.getDeviceHeigth() * 0.02,
        ),
        TextContainerWidget(text: SharedPreferencesUtil().getEmail()),
        SizedBox(
          height: context.getDeviceHeigth() * 0.02,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: MyTextField(
              controller: viewModel.fullnameController,
              hintText: LocaleKeys.fullName.locale,
            )),
        SizedBox(
          height: context.getDeviceHeigth() * 0.02,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: MyAuthButton(onTap: () async => viewModel.updateNameMethod(context), text: LocaleKeys.updateInformation.locale)),
      ],
    );
  }

  _buildDialogRow(String title, Icon icon, Function() onTap, BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyleConstants.appBarTextStyle.copyWith(fontSize: 16)),
          SizedBox(
            width: context.getDeviceHeigth() * 0.03,
          ),
          icon
        ],
      ),
    );
  }
}
