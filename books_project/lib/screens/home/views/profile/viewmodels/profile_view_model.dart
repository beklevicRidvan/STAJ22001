import 'dart:async';

import 'package:books_project/base/viewmodels/base_view_model.dart';
import 'package:books_project/screens/home/views/profile/profile_service.dart';

class ProfileViewModel extends BaseViewModel{
  ProfileService service;


  ProfileViewModel({required this.service});



  @override
  FutureOr<void> init() async{
  }

}