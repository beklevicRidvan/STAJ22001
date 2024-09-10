import 'dart:convert';

import 'package:flutter_fake_api/base/constants/app_constants.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  dynamic userId;
  String fullName;
  String email;
  double balance;
  String imageUrl;

  UserModel({this.userId, required this.email, required this.fullName, this.balance = 1000.00, this.imageUrl = LocaleConstants.networkImageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(userId: json["userId"], fullName: json["fullName"], email: json["email"], balance: json["balance"], imageUrl: json["imageUrl"]);

  Map<String, dynamic> toJson({dynamic key}) => {
        "userId": key ?? userId,
        "fullName": fullName,
        "email": email,
        "balance": 1000.5,
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/firestore-uygulamalari.appspot.com/o/placheholder.png?alt=media&token=73b4585d-2129-437c-aaee-ad2ecacd3797"
      };
}
