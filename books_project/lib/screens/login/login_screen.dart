import 'package:flutter/material.dart';

import '../../base/views/base_view.dart';
import 'service/login_service.dart';
import 'viewmodels/login_view_model.dart';
import 'views/login_form_view.dart';

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