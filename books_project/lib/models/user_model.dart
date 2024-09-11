import 'dart:convert';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  dynamic userId;
  String fullName;
  String email;


  UserModel({this.userId, required this.email, required this.fullName});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(userId: json["userId"], fullName: json["fullName"], email: json["email"]);

  Map<String, dynamic> toJson({dynamic key}) => {
    "userId": key ?? userId,
    "fullName": fullName,
    "email": email,
  };
}