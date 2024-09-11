import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/constants/app_constants.dart';
import '../../../components/my_authbutton.dart';
import '../../../components/my_text_field.dart';
import '../../../utils/navigation_utils.dart';
import '../viewmodels/login_view_model.dart';


class LoginFormView extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginFormView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return IgnorePointer(
        ignoring: viewModel.isLoading,
        child: Padding(
          padding: const EdgeInsets.all(AppEdgeInsetsConstants.mediumPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                controller: viewModel.emailController,
                hintText: "Email",
                onChanged: (p0) {
                  viewModel.email = p0;
                  debugPrint(viewModel.email);
                },
              ),
              const SizedBox(height: 12),
              MyTextField(
                controller: viewModel.passwordController,
                hintText: "Password",
                isObscureValue: viewModel.isObscureValue,
                isPassword: true,
                onPressed: viewModel.changeObscureValueState,
              ),
              const SizedBox(height: 10),
              MyAuthButton(onTap: () async => await viewModel.signIn(context), text: "Login"),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("İs has not a account"),
                  TextButton(
                      onPressed: () => NavigationUtils.navigateToSignUpScreen(context),
                      child:  const Text(
                        "SignUP",
                        style: TextStyle(fontSize: 17, color: AppColorConstants.whiteColor, fontWeight: AppFontWeightConstants.bold),
                      )),
                ],
              ),

            ],
          ),
        ));
  }
}