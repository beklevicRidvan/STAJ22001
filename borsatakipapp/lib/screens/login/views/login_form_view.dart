import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/constants/app_constants.dart';
import 'package:flutter_fake_api/components/my_authbutton.dart';
import 'package:flutter_fake_api/components/my_text_field.dart';
import 'package:flutter_fake_api/screens/login/viewmodels/login_view_model.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:flutter_fake_api/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

import '../../../base/enums/language_type_enum.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/translations/translations_view_model.dart';

class LoginFormView extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginFormView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<AppLanguage>(context);

    return IgnorePointer(
        ignoring: viewModel.isLoading,
        child: Padding(
          padding: const EdgeInsets.all(AppEdgeInsetsConstants.mediumPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                controller: viewModel.emailController,
                hintText: LocaleKeys.emailHint.locale,
                onChanged: (p0) {
                  viewModel.email = p0;
                  debugPrint(viewModel.email);
                },
              ),
              SizedBox(height: context.getDeviceHeigth() * 0.02),
              MyTextField(
                controller: viewModel.passwordController,
                hintText: LocaleKeys.passwordHint.locale,
                isObscureValue: viewModel.isObscureValue,
                isPassword: true,
                onPressed: viewModel.changeObscureValueState,
              ),
              SizedBox(height: context.getDeviceHeigth() * 0.04),
              MyAuthButton(onTap: () async => await viewModel.signIn(context), text: LocaleKeys.login.locale),
              SizedBox(
                height: context.getDeviceHeigth() * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(LocaleKeys.isntAccount.locale),
                  TextButton(
                      onPressed: () => NavigationUtils.navigateToSignUpScreen(context),
                      child:  Text(
                        LocaleKeys.signUp.locale,
                        style: TextStyle(fontSize: 17, color: AppColorConstants.whiteColor, fontWeight: AppFontWeightConstants.bold),
                      )),
                ],
              ),
             ChangeNotifierProvider.value(value: languageModel,child:  DropdownButtonHideUnderline(
               child: DropdownButton(
                 isExpanded: false,
                 value: languageModel.language,
                 icon: Container(
                   width: 100,
                   child: Row(
                     children: [
                       Icon(Icons.arrow_drop_down_sharp, size: 50, color: Colors.black),
                     ],
                   ),
                 ),
                 items: LanguagesType.values
                     .map((e) => e.name)
                     .toList()
                     .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(value: "$value", child: Text('$value')))
                     .toList(),
                 onChanged: (String? val) async => await languageModel.changeLanguage(val, context),
               ),
             ),)
              ,

            ],
          ),
        ));
  }
}
