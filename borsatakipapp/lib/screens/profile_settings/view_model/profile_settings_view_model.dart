import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:flutter_fake_api/components/alert_dialog.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../profile_settings_service.dart';

class ProfileSettingsScreenViewModel extends BaseViewModel{
  ProfileSettingsService service;
  String? fullName;
  String? profImage;

  TextEditingController _fullnameController = TextEditingController();

  ProfileSettingsScreenViewModel({required this.service});



  @override
  FutureOr<void> init() {
    _fullnameController.text = SharedPreferencesUtil().getFullName() ?? "";
    refresh();
  }


  Future<void> updateNameMethod(BuildContext context)async{
    isLoading = true;
    try{

      await service.updateUserFullName(SharedPreferencesUtil().getUserId(), _fullnameController.text);

      SharedPreferencesUtil().setFullName(_fullnameController.text);
      fullName = SharedPreferencesUtil().getFullName();
      reloadState();
    }
    catch(e){
      showMyDialog(context,e.toString());
    }
    finally{
      isLoading = false;
    }

  }


  Future<void> takeAPicture(ImageSource source,BuildContext context)async{
    isLoading = true;
    try{
      String? myUrl = await service.takePictureBySource(source);
      debugPrint(myUrl);

      if(myUrl != null){
        SharedPreferencesUtil().setImage(myUrl);
        profImage = SharedPreferencesUtil().getImage();
        reloadState();

      }
    }
    catch(e){
      showMyDialog(context, e.toString());
    }
    finally{
      isLoading = false;

    }
  }


  void refresh(){
    SharedPreferencesUtil().getFullName();
    SharedPreferencesUtil().getImage();
    reloadState();
  }





    TextEditingController get fullnameController => _fullnameController;

}