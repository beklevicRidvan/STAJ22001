import 'dart:async';

import 'package:flutter/material.dart';

import '../../../base/services/network_response_services.dart';
import '../../../base/viewmodels/base_view_model.dart';
import '../../../components/alert_dialog.dart';
import '../../../models/user_model.dart';
import '../register_service.dart';

class SignupViewModel extends BaseViewModel{
  SignupService service;
  bool _isObscureValue = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();


  SignupViewModel({required this.service});



  @override
  FutureOr<void> init() {
    // TODO: implement init
  }


  bool get isObscureValue => _isObscureValue;

  void changeObscureValueState()=> isObscureValue = !isObscureValue;


  set isObscureValue(bool value) {
    _isObscureValue = value;
    reloadState();
  }



  Future<NetworkResponseServices> signUpUser(BuildContext context)async{
    isLoading = true;
    if(_passwordController.text == _confirmpwController.text){
      var user = UserModel(email: _emailController.text, fullName: _nameController.text);
      var response =await service.registerWithEmailAndPassword(user, _passwordController.text);
      return response;
    }
    else {
      showMyDialog(context, 'Şifreler uyuşmuyor');
    }
    isLoading = false;
    return NetworkResponseServices(isSucces: false, data: null, errorMessage: 'HATA ÇIKTI');

  }

  TextEditingController get confirmpwController => _confirmpwController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get emailController => _emailController;

  TextEditingController get nameController => _nameController;
}