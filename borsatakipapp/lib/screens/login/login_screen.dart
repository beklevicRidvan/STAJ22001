import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/screens/login/service/login_service.dart';
import 'package:flutter_fake_api/screens/login/viewmodels/login_view_model.dart';
import 'package:flutter_fake_api/screens/login/views/login_form_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseView<LoginViewModel>(vmBuilder: (_) => LoginViewModel(service: LoginService()), builder: _buildScreen),
    );
  }

  Widget _buildScreen(BuildContext context, LoginViewModel viewModel) {
    return LoginFormView(viewModel: viewModel,);
  }
}
