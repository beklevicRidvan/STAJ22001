import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/components/image_customize_widget.dart';
import 'package:flutter_fake_api/screens/home/view/markets/viewmodel/market_view_model.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:flutter_fake_api/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

import '../../../../base/constants/app_constants.dart';
import '../../../../base/views/base_view.dart';
import '../../../../components/appbar_widget.dart';
import '../../../../components/my_text_field.dart';
import '../../../../models/money_model.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/sharred_preferences_utils.dart';
import 'market_service.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    String type = context.locale == LocaleConstants.trLocale ? "TRY" : "USD";
    return BaseView<MarketViewModel>(
      vmBuilder: (_) => MarketViewModel(service: MarketService(), type: type),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, MarketViewModel viewModel) {
    return IgnorePointer(
      ignoring: viewModel.isLoading,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppbarWidget(title: LocaleKeys.homeAppbarTitle.locale),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.01,
                  ),
                  _buildContainer([
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          LocaleKeys.balance.locale,
                          style: AppTextStyleConstants.normalTextStyle,
                        ),
                        Text(
                          "${SharedPreferencesUtil().getBalance()} ${context.locale == LocaleConstants.trLocale ? '₺' : '\$'}",
                          style: AppTextStyleConstants.appBarTextStyle,
                        ),
                      ],
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProcessRow(
                          LocaleKeys.depositMoney.locale,
                          () => showDialogBalance(
                              context,
                              viewModel,
                              LocaleKeys.deposit.locale,
                              () {
                                if (viewModel.priceValue > 0) {
                                  viewModel.decreaseBalance(100.00);
                                }
                              },
                              () => viewModel.increaseBalance(100.00),
                              () async {
                                await viewModel.depositMoney(context);
                              }),
                          const Icon(Icons.add_card_outlined),
                        ),
                        _buildProcessRow(LocaleKeys.withdrawMoney.locale, () {
                          showDialogBalance(context, viewModel, LocaleKeys.withDraw.locale, () {
                            if (SharedPreferencesUtil().getBalance()! >= viewModel.priceValue) {
                              viewModel.decreaseBalance(100);
                            }
                          }, () {
                            if (SharedPreferencesUtil().getBalance()! <= viewModel.priceValue) {
                              viewModel.increaseBalance(100);
                            }
                          }, () async => await viewModel.withDrawMoney(context));
                        }, const Icon(Icons.compare_arrows_sharp)),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.03,
                  ),
                  Text(
                    LocaleKeys.listsText.locale,
                    style: AppTextStyleConstants.appBarTextStyle,
                  ),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.01,
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                      onTap: ()=> NavigationUtils.navigateToFollowedByScreen(context),
                        child:                       _buildListContainer(LocaleKeys.followedBy.locale, viewModel.followedListLength, context),

                      ),
                      GestureDetector(
                        onTap: ()=> NavigationUtils.navigateToMyCryptosScreen(context),
                        child: _buildListContainer(LocaleKeys.shares.locale, 8, context),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.02,
                  ),
                  Text(
                    LocaleKeys.rate.locale,
                    style: AppTextStyleConstants.appBarTextStyle,
                  ),
                  SizedBox(
                    height: context.getDeviceHeigth() * 0.01,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.moneys.length,
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MyLocaleClass.crossAxisCount,
                      mainAxisExtent: context.getDeviceHeigth() * 0.1,
                      mainAxisSpacing: context.getDeviceHeigth() * 0.02,
                      crossAxisSpacing: context.getDeviceHeigth() * 0.03,
                    ),
                    itemBuilder: (context, index) => _buildGridListItem(context, viewModel, viewModel.moneys[index]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDialogBalance(
      BuildContext context, MarketViewModel viewModel, String okeyString, Function() decraseFunc, Function() incraseFunc, Function() asyncFunc) {
    return showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<MarketViewModel>(
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
                        viewModel.priceValue = 0.0;
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
                        viewModel.priceValue = 0.0;
                        viewModel.balanceController.text = '0.0';
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
                      child: Text(okeyString, style: AppTextStyleConstants.authButtonTextStyle)),
                ],
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildGridListItem(BuildContext context, MarketViewModel viewModel, MoneyModel money) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadiusConstants.miniRadius),
            color: AppColorConstants.chipColor.withOpacity(0.3),
            boxShadow: const [BoxShadow(color: AppColorConstants.ligtGreyColor, blurRadius: 0.1, spreadRadius: 3)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(money.name ?? ""),
              Text(money.rate?.toStringAsFixed(3) ?? 0.0.toString()),
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 10,
            child: Image.network(
              money.iconUrl,
              fit: BoxFit.contain,
              width: 20,
            )),
      ],
    );
  }

  _buildContainer(List<Widget> widgetElements) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadiusConstants.largeRadius),
        color: AppColorConstants.ligtGreyColor.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widgetElements,
        ),
      ),
    );
  }

  _buildListContainer(String title, int count, BuildContext context) {
    return Container(
      width: context.getDeviceHeigth() * 0.2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadiusConstants.largeRadius),
        color: AppColorConstants.ligtGreyColor.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(LocaleConstants.eyePath, fit: BoxFit.contain),
          Text(title),
          SizedBox(
            height: context.getDeviceHeigth() * 0.01,
          ),
          Text('($count)'),
        ],
      ),
    );
  }

  _buildProcessRow(String title, Function() onTap, Icon icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColorConstants.chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppBorderRadiusConstants.miniRadius),
      ),
      child: Row(
        children: [
          Text(title),
          IconButton(
            onPressed: onTap,
            icon: icon,
          ),
        ],
      ),
    );
  }
}

class MyLocaleClass {
  static const int crossAxisCount = 3;
}
