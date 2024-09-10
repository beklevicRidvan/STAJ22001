class CryptoModel {
  dynamic coinId;
  String coinCode;
  String coinName;
  String iconUrl;
  double price;

  CryptoModel({this.coinId, required this.coinCode, required this.coinName, required this.iconUrl, required this.price});

  factory CryptoModel.fromMap(Map<String, dynamic> data) {
    return CryptoModel(
        coinId: data['coinId'], coinCode: data['coinCode'], coinName: data['coinName'], iconUrl: data['iconUrl'], price: data['price']);
  }



  Map<String,dynamic> toMap(dynamic key){
    return {
      "coinId":key,
    };
  }
}
