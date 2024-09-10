import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/screens/home/view/search/search_service.dart';
import 'package:flutter_fake_api/screens/home/view/search/viewmodel/search_view_model.dart';

import '../../../../components/crypto_list_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchViewModel>(
      vmBuilder: (_) => SearchViewModel(service: SearchService()),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, SearchViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            title: viewModel.isVisible
                ? CupertinoSearchTextField(
              controller: viewModel.searchingController,
              autofocus: viewModel.isVisible,
              onChanged: (value) async => viewModel.getDatas(),
            )
                : const Text('COINS'),
            actions: [
              IconButton(
                onPressed: () {
                  if (viewModel.isVisible) {
                    viewModel.clearSearch(); // Clear arama ve eski listeyi geri yükle
                  } else {
                    viewModel.isVisible = !viewModel.isVisible;
                  }
                },
                icon: viewModel.isVisible ? const Icon(Icons.clear) : const Icon(Icons.search),
              ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 3),
            itemCount: viewModel.cryptos.length,
            itemBuilder: (context, index) {
              var currentElement = viewModel.cryptos[index];
              return BuildListItem(
                currentElement: currentElement,
              );
            },
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
