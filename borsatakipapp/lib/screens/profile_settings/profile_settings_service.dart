import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fake_api/base/services/firebase_service.dart';
import 'package:flutter_fake_api/translations/locale_keys.g.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsService {
  Future<void> updateUserFullName(String? userId,String newName) async{
    User? currentUser= FirebaseService.firebaseAuth.currentUser;

    try {
      if(currentUser != null){
        await FirebaseService.firebaseFirestore.collection('myUsers').doc(userId ?? currentUser.uid).update({
          'fullName':newName
        });
      }
      else {
        throw Exception(LocaleKeys.userEmptyError.locale);
      }


    } catch (e) {
      throw Exception(e.toString());
    }
  }



  Future<String?> takePictureBySource(ImageSource sourceType) async {
    String? myUrl = null;
    try {
      final ImagePicker picker = ImagePicker();

      User? user = FirebaseService.firebaseAuth.currentUser;
      if (user != null) {
        XFile? file = await picker.pickImage(source: sourceType);
        if (file != null) {
          var profileRef = FirebaseService.firebaseStorage.ref("myUsers/profilePic/${user.uid}");
          var task = profileRef.putFile(
              File(file.path), SettableMetadata(contentType: 'image/png'));
          await task.whenComplete(() async {
            var url = await profileRef.getDownloadURL();
            await FirebaseService.firebaseFirestore.collection("myUsers").doc(user.uid).set({
              "imageUrl": url.toString(),
            }, SetOptions(merge: true));
            debugPrint("url ${url.toString()}");
            myUrl = url.toString();
            return myUrl;
          });
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return myUrl;
  }

}
