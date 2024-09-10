import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/components/appbar_widget.dart';
import 'package:flutter_fake_api/components/image_customize_widget.dart';
import 'package:flutter_fake_api/models/crypto_model.dart';
import 'package:flutter_fake_api/screens/crypto_detail_screen/crypto_detail_service.dart';
import 'package:flutter_fake_api/screens/crypto_detail_screen/viewModel/crypto_detail_view_model.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:provider/provider.dart';

import '../../components/my_text_field.dart';
import '../../translations/locale_keys.g.dart';
import '../../utils/navigation_utils.dart';

class CryptoDetailView extends StatelessWidget {
  final CryptoModel cryptoModel;
  const CryptoDetailView({super.key, required this.cryptoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CryptoDetailViewModel>(
          vmBuilder: (_) => CryptoDetailViewModel(service: CryptoDetailService(), cryptoModel: cryptoModel), builder: _buildScreenContent),
    );
  }

  Widget _buildScreenContent(BuildContext context, CryptoDetailViewModel viewModel) {
    double myValue = context.getDeviceHeigth() * 0.05;
    return Column(
      children: [
        AppbarWidget(
          title: cryptoModel.coinName,
          isAutomaticlyLeading: true,
        ),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: myValue),
              width: context.getDeviceHeigth() * 0.4,
              height: context.getDeviceHeigth() * 0.4,
              padding: const EdgeInsets.all(AppEdgeInsetsConstants.miniPadding),
              decoration: BoxDecoration(
                color: AppColorConstants.authColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppBorderRadiusConstants.miniRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(AppBorderRadiusConstants.veryXLargeRadius),
                      child: ImageCustomizeWidget(
                        imgUrl: cryptoModel.iconUrl,
                        value: 0.1,
                      )),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.02,
                  ),
                  Text(
                    cryptoModel.coinCode,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.03,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(LocaleKeys.unitPrice.locale),
                      SizedBox(
                        width: context.getDeviceHeigth() * 0.03,
                      ),
                      Text(
                        cryptoModel.price.toString(),
                        style: AppTextStyleConstants.appBarTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.02,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          viewModel.balanceController.text = cryptoModel.price.toString();
                          showDialogBalance(context, viewModel, () => viewModel.decreaseBalance(1), () => viewModel.increaseBalance(1), () async {
                            bool value = await viewModel.addCryptosForCrypto(context);
                            if(value){
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Text(
                          LocaleKeys.buyCrypto.locale,
                          style: AppTextStyleConstants.authButtonTextStyle,
                        )),
                  )
                ],
              ),
            ),
            Positioned(
                right: myValue * 0.04,
                top: myValue * 1.02,
                child: IconButton(
                    onPressed: () async {
                      if (viewModel.isFavorited) {
                        viewModel.deleteFavoritesCryptoByUser(context);
                      } else {
                        viewModel.addFavoritesForCrypto(context);
                      }
                    },
                    icon: viewModel.isFavorited ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border_rounded)))
          ],
        )
      ],
    );
  }

  GestureDetector gestureDetector(Function() func, String icon) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColorConstants.scafoldBackGroundColor.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: Text(
          icon,
          style: AppTextStyleConstants.appBarTextStyle.copyWith(fontSize: 20),
        ),
      ),
    );
  }

  Future<dynamic> showDialogBalance(
      BuildContext context, CryptoDetailViewModel viewModel, Function() decraseFunc, Function() incraseFunc, Function() asyncFunc) {
    return showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<CryptoDetailViewModel>(
          builder: (context, viewModel, _) => AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyTextField(
                    controller: viewModel.balanceController,
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {
                        viewModel.priceValue = double.parse(p0);
                      } else {
                        viewModel.priceValue = 1;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: context.getDeviceHeigth() * 0.02,
                ),
                Row(
                  children: [
                    gestureDetector(decraseFunc, '-'),
                    SizedBox(
                      width: context.getDeviceHeigth() * 0.01,
                    ),
                    Text(viewModel.priceValue.toString()),
                    SizedBox(
                      width: context.getDeviceHeigth() * 0.01,
                    ),
                    gestureDetector(incraseFunc, '+'),
                  ],
                ),
              ],
            ),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        viewModel.priceValue = 1;
                        viewModel.balanceController.text = cryptoModel.price.toString();
                        NavigationUtils.navigateToBack(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColorConstants.scafoldBackGroundColor),
                      child: Text(
                        LocaleKeys.cancel.locale,
                        style: AppTextStyleConstants.authButtonTextStyle,
                      )),
                  ElevatedButton(
                      onPressed: asyncFunc,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColorConstants.scafoldBackGroundColor),
                      child: Text('TAMAM', style: AppTextStyleConstants.authButtonTextStyle)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
