import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/components/appbar_widget.dart';
import 'package:flutter_fake_api/components/crypto_list_item.dart';
import 'package:flutter_fake_api/screens/followed_by_screen/followedby_service.dart';
import 'package:flutter_fake_api/screens/followed_by_screen/viewModel/followedby_view_model.dart';
import 'package:flutter_fake_api/translations/locale_keys.g.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

import '../../components/snackbar_widget.dart';

class FollowedbyScreen extends StatelessWidget {
  const FollowedbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<FollowedByViewModel>(vmBuilder: (_) => FollowedByViewModel(service: FollowedByViewService()), builder: _buildScreenContent),
    );
  }

  Widget _buildScreenContent(BuildContext content, FollowedByViewModel viewModel) {
    return Column(
      children: [
        AppbarWidget(title: LocaleKeys.followedBy.locale,isAutomaticlyLeading: true,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.followedCryptos.length,
          itemBuilder: (context, index) {
            var currentElement = viewModel.followedCryptos[index];
            return BuildListItem(currentElement: currentElement,isFollowedPage: true,deleteFunc: () => showSnackBar(context,'${currentElement.coinCode} ${LocaleKeys.sureWithCoinDelete.locale}',() async=> await viewModel.deleteFollowedList(currentElement, context),));
    } ),


      ],
    );
  }
}
