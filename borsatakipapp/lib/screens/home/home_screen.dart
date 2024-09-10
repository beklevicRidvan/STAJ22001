import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/components/build_bottombar_widget.dart';
import 'package:flutter_fake_api/screens/home/service/home_service.dart';
import 'package:flutter_fake_api/screens/home/view/markets/market_view.dart';
import 'package:flutter_fake_api/screens/home/view/profile/profile_view.dart';
import 'package:flutter_fake_api/screens/home/view/search/search_view.dart';
import 'package:flutter_fake_api/screens/home/viewModel/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<HomeViewModel>(
        vmBuilder: (_) => HomeViewModel(service: HomeService()),
        builder: _buildScreen,
      ),
    );
  }

  Widget _buildScreen(BuildContext p1, HomeViewModel viewModel) {
    return Scaffold(
      body: getBody(viewModel),
      bottomNavigationBar: BuildBottombarWidget(viewModel: viewModel),
    );
  }

  getBody(HomeViewModel viewModel) {
   switch (viewModel.selectedIndex){
     case 0:
       return const MarketView();
     case 1:
       return const SearchView();
     case 2:
       return const ProfileView();
     default:
       return Container();
   }

  }
}
