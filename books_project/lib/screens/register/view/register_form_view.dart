import 'package:flutter/material.dart';

import '../../../base/constants/app_constants.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/my_authbutton.dart';
import '../../../components/my_text_field.dart';
import '../../../utils/navigation_utils.dart';
import '../viewmodels/register_view_model.dart';

class SignupFormView extends StatelessWidget {
  final SignupViewModel viewModel;
  const SignupFormView({super.key,required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(ignoring: viewModel.isLoading,child: Padding(
      padding: const EdgeInsets.all(AppEdgeInsetsConstants.mediumPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(controller: viewModel.nameController,hintText: 'Ad Soyad',),
          const SizedBox(height: 12,),
          MyTextField(controller: viewModel.emailController,hintText: 'Email',),
          const SizedBox(height: 12,),
          MyTextField(controller: viewModel.passwordController,isPassword:true,hintText: 'Parola',isObscureValue: viewModel.isObscureValue,onPressed: viewModel.changeObscureValueState,),
          const SizedBox(height: 12,),
          MyTextField(controller: viewModel.confirmpwController,isObscureValue: viewModel.isObscureValue,hintText: 'Parolayı onaylayın',),

          const SizedBox(height: 20,),
          MyAuthButton(onTap: ()async{
            var response = await viewModel.signUpUser(context);
            if(response.isSucces){
              NavigationUtils.navigateToHomeScreen(context);
            }
            else {
              showMyDialog(context, response.errorMessage);
            }

          }, text: 'Kayıt Ol'),
          const SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hesabın var mı?'),
              TextButton(onPressed: ()=>NavigationUtils.navigateToLoginScreen(context), child:  const Text('Giriş yap',style: TextStyle(fontSize: 17,color: AppColorConstants.whiteColor,fontWeight: AppFontWeightConstants.bold),)),

            ],)
        ],
      ),
    ));
  }
}