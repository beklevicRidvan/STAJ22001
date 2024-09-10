import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/views/base_view.dart';
import 'package:flutter_fake_api/screens/signup/service/signup_service.dart';
import 'package:flutter_fake_api/screens/signup/viewmodels/signup_view_model.dart';
import 'package:flutter_fake_api/screens/signup/views/signup_form_view.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: BaseView<SignupViewModel>(vmBuilder: (_) => SignupViewModel(service: SignupService()), builder: _buildScreen),
    );
  }

  Widget _buildScreen(BuildContext context, SignupViewModel viewModel) {
    return IgnorePointer(ignoring: viewModel.isLoading,child: SignupFormView(viewModel: viewModel));
  }
}
