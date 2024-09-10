import 'package:flutter_fake_api/models/crypto_model.dart';

class MyCryptoModel {
  CryptoModel cryptoModel;
  double piece;
  double totalPrice;

  MyCryptoModel({required this.cryptoModel, required this.piece, required this.totalPrice});

  factory MyCryptoModel.fromMap(Map<String, dynamic> data, CryptoModel myCryptoModel) {
    return MyCryptoModel(cryptoModel: myCryptoModel, piece: data["piece"], totalPrice: data["totalPrice"]);
  }
}
