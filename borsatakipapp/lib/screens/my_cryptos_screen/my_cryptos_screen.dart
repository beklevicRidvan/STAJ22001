import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/components/appbar_widget.dart';
import 'package:flutter_fake_api/screens/my_cryptos_screen/my_cryptos_screen_service.dart';
import 'package:flutter_fake_api/screens/my_cryptos_screen/viewmodels/my_cryptos_view_model.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';

class MyCryptosScreen extends StatelessWidget {
  const MyCryptosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView(vmBuilder: (_) => MyCryptosViewModel(service: MyCryptosScreenService()), builder: _buildScreenContent),
    );
  }

  Widget _buildScreenContent(BuildContext context, MyCryptosViewModel viewModel) {
    return Column(
      children: [
        const AppbarWidget(
          title: "My Cryptos",
          isAutomaticlyLeading: true,
        ),
        if (viewModel.myCryptos.isNotEmpty)
          ListView.builder(
            itemCount: viewModel.myCryptos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var element = viewModel.myCryptos[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(element.cryptoModel.iconUrl),
                    child: Image.network(
                      element.cryptoModel.iconUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.warning_amber);
                      },
                    ),
                  ),

                  title:
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.cryptoModel.coinCode,
                        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      Text(element.cryptoModel.coinName),
                    ],
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Alınan adet: ${element.piece.toStringAsFixed(0)}  "),
                            Text("Toplam Fiyat: ${element.totalPrice.toStringAsFixed(2)}")
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              bool value = await viewModel.deleteAndSellCrypto(element);
                              if (value) {
                                SharedPreferencesUtil().setBalance(SharedPreferencesUtil().getBalance()! + element.totalPrice);
                                viewModel.reloadState();
                                await viewModel.fetchDatas();
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                            child: const Text(
                              "Sat",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        if (viewModel.myCryptos.isEmpty) const Center(child: Text("Satın alınmış cryptonuz bulunmuyor! Search ekranından satın alın"))
      ],
    );
  }
}
