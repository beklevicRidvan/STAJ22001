import 'package:flutter/material.dart';
import 'package:flutter_fake_api/components/alert_dialog.dart';
import 'package:flutter_fake_api/components/my_authbutton.dart';
import 'package:flutter_fake_api/components/my_text_field.dart';
import 'package:flutter_fake_api/screens/signup/viewmodels/signup_view_model.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:flutter_fake_api/utils/navigation_utils.dart';

import '../../../base/constants/app_constants.dart';

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
          SizedBox(height: context.getDeviceHeigth()*0.02,),
          MyTextField(controller: viewModel.emailController,hintText: 'Email',),
          SizedBox(height: context.getDeviceHeigth()*0.02,),
          MyTextField(controller: viewModel.passwordController,isPassword:true,hintText: 'Parola',isObscureValue: viewModel.isObscureValue,onPressed: viewModel.changeObscureValueState,),
          SizedBox(height: context.getDeviceHeigth()*0.02,),
          MyTextField(controller: viewModel.confirmpwController,isObscureValue: viewModel.isObscureValue,hintText: 'Parolayı onaylayın',),

          SizedBox(height: context.getDeviceHeigth()*0.04,),
          MyAuthButton(onTap: ()async{
             var response = await viewModel.signUpUser(context);
             if(response.isSucces){
               NavigationUtils.navigateToHomeScreen(context);
             }
             else {
               showMyDialog(context, response.errorMessage);
             }

          }, text: 'Kayıt Ol'),
          SizedBox(height: context.getDeviceHeigth()*0.01,),

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
