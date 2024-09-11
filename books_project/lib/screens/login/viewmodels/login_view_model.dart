import 'dart:async';

import 'package:flutter/material.dart';

import '../../../base/viewmodels/base_view_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/sharredpref_util.dart';
import '../service/login_service.dart';

class LoginViewModel extends BaseViewModel{
  LoginService service;
  bool _isObscureValue = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _email;
  String? errorMessage;


  String? get email => _email;

  set email(String? value) {
    _email = value;
    reloadState();
  }

  LoginViewModel({required this.service});


  @override
  FutureOr<void> init() {

  }

  void changeObscureValueState ()=> isObscureValue = !isObscureValue;

  bool get isObscureValue => _isObscureValue;

  set isObscureValue(value) {
    _isObscureValue = value;
    reloadState();
  }


  Future<bool>  signIn(BuildContext context)async{
    isLoading = true;
    var isSuccess = false;
    var response = await service.signIn(email!, _passwordController.text);
    if(response.isSucces && response.data != null){
      var user = UserModel.fromJson(response.data);
      debugPrint(response.data.toString());
      debugPrint(user.email+user.fullName);
      SharedPreferencesUtil().setEmail(user.email);
      SharedPreferencesUtil().setFullName(user.fullName);
      SharedPreferencesUtil().setUserId(user.userId);

      isSuccess = true;
    }


    isLoading = false;
    return isSuccess;
  }


  TextEditingController get passwordController => _passwordController;

  TextEditingController get emailController => _emailController;
}