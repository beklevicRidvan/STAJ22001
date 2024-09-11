class BookModel {
  dynamic kitapId;
  String kitapAdi;

  BookModel({this.kitapId, required this.kitapAdi});

  factory BookModel.fromMap(Map<String, dynamic> data) {
    return BookModel(kitapAdi: data['kitapAdi'], kitapId: data['kitapId']);
  }



  Map<String,dynamic> toMap(String key){
    return {
      "kitapId":key,
      "kitapAdi":kitapAdi
    };
  }
}
