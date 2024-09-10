import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/components/appbar_widget.dart';
import 'package:flutter_fake_api/components/image_customize_widget.dart';
import 'package:flutter_fake_api/components/nonnullable_text.dart';
import 'package:flutter_fake_api/components/profile_list_item.dart';
import 'package:flutter_fake_api/components/user_info_container.dart';
import 'package:flutter_fake_api/screens/home/view/profile/profile_service.dart';
import 'package:flutter_fake_api/screens/home/view/profile/viewmodel/profile_view_model.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';
import 'package:provider/provider.dart';

import '../../../../translations/locale_keys.g.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(vmBuilder: (_) => ProfileViewModel(service: ProfileService()), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, ProfileViewModel viewModel) {
    List<String> profileInfoList = [
      LocaleKeys.profileSettings.locale,
      LocaleKeys.favorites.locale,
      LocaleKeys.balance.locale,
      LocaleKeys.about.locale,
      LocaleKeys.logout.locale
    ];

    return SingleChildScrollView(
      child: SizedBox(
        height: context.getDeviceHeigth(),
        child: Column(
          children: [
            SizedBox(height: context.getDeviceHeigth()*0.1,child: AppbarWidget(title: LocaleKeys.profileAppbarTitle.locale)),
            Expanded(
                child: Container(
                  height: context.getDeviceHeigth()*0.9,
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserInfoContainer(
                      imgUrl: SharedPreferencesUtil().getImage(),
                      userName: SharedPreferencesUtil().getFullName(),
                      userEmail: SharedPreferencesUtil().getEmail()),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.02,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: profileInfoList.length,
                    itemBuilder: (context, index) => ProfileListItem(
                      index: index,
                      length: profileInfoList.length,
                      func: () async {
                        await SharedPreferencesUtil().removeAll();
                        await viewModel.signOut(context);
                      } ,
                      title: profileInfoList[index],
                      favoritesFunc: () => showDialog(
                        context: context,
                        builder: (_) => ChangeNotifierProvider<ProfileViewModel>.value(
                          value: viewModel,
                          child: Consumer<ProfileViewModel>(
                            builder: (context, value, child) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                child: value.cryptos.isEmpty ? const Center(child: Text(" Favorileriniz boş favoriye ekleyin")):GridView.builder(
                                  shrinkWrap: true,

                                  itemCount: viewModel.cryptos.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: context.getDeviceHeigth() * 0.01,
                                      mainAxisSpacing: context.getDeviceHeigth() * 0.01),
                                  itemBuilder: (context, index) => Container(
                                    color: AppColorConstants.chipColor.withOpacity(0.2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius : BorderRadius.circular(AppBorderRadiusConstants.veryXLargeRadius),
                                          child: ImageCustomizeWidget(
                                            imgUrl: viewModel.cryptos[index].iconUrl,
                                            value: 0.05,
                                          ),
                                        ),
                                        Text(viewModel.cryptos[index].coinCode)
                                      ],
                                    ),
                                  ),
                                ));
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
