import 'package:books_project/screens/home/viewmodels/home_view_model.dart';
import 'package:books_project/screens/home/views/profile/profile_view.dart';
import 'package:flutter/material.dart';

import '../../base/views/base_view.dart';
import '../../components/build_bottombar_widget.dart';
import 'service/home_service.dart';
import 'views/book/book_view.dart';

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
        return const  BookView();
      case 1:
        return const ProfileView();
      default:
        return Container();
    }

  }
}