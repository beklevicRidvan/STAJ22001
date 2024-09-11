import 'package:books_project/screens/register/register_service.dart';
import 'package:books_project/screens/register/view/register_form_view.dart';
import 'package:flutter/material.dart';

import '../../base/views/base_view.dart';
import 'viewmodels/register_view_model.dart';

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