import 'package:flutter/material.dart';

import '../screens/home/viewmodels/home_view_model.dart';

class BuildBottombarWidget extends StatelessWidget {
  final HomeViewModel viewModel;

  const BuildBottombarWidget({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items:const [
      BottomNavigationBarItem(icon:  Icon(Icons.book_outlined),label: ""),
      BottomNavigationBarItem(icon:  Icon(Icons.person_outline),label: ""),



    ],onTap: (value) => viewModel.selectedIndex = value,
      currentIndex: viewModel.selectedIndex,

    );
  }
}