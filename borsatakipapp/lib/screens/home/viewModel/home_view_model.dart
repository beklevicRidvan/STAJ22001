import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:image_picker/image_picker.dart';

import '../service/home_service.dart';
//flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

class HomeViewModel extends BaseViewModel{
  int _selectedIndex = 0;
  String? fullName;
  String? email;
  final HomeService service;
  final  PageController _pageController = PageController(initialPage: 0);

  HomeViewModel({required this.service});



  void changePage (int value){
    selectedIndex = value;
    _pageController.jumpToPage(selectedIndex);
    reloadState();
  }

  @override
  FutureOr<void> init() async{
    isLoading = true;
    const  Duration(seconds: 2);
    isLoading = false;
  }
























  Future<void> takePictureByCamera() async {
    try {
      final ImagePicker picker = ImagePicker();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        XFile? file = await picker.pickImage(source: ImageSource.camera);
        if (file != null) {
          var profileRef = FirebaseStorage.instance.ref("users/profilePic/${user.uid}");
          var task = profileRef.putFile(
              File(file.path), SettableMetadata(contentType: 'image/png'));
          await task.whenComplete(() async {
            var url = await profileRef.getDownloadURL();
            await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
              "photoUrl": url.toString(),
            }, SetOptions(merge: true));
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  set selectedIndex(int value) {
    _selectedIndex = value;
    reloadState();
  }


  int get selectedIndex => _selectedIndex;




  get pageController => _pageController;
}