import 'package:flutter/material.dart';
import 'package:flutter_fake_api/screens/home/viewModel/home_view_model.dart';

class BuildBottombarWidget extends StatelessWidget {
  final HomeViewModel viewModel;

  const BuildBottombarWidget({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items:const [
      BottomNavigationBarItem(icon:  Icon(Icons.account_balance),label: ""),
      BottomNavigationBarItem(icon:  Icon(Icons.search),label: ""),
      BottomNavigationBarItem(icon:  Icon(Icons.person_outline),label: ""),



    ],onTap: (value) => viewModel.selectedIndex = value,
      currentIndex: viewModel.selectedIndex,

    );
  }
}
