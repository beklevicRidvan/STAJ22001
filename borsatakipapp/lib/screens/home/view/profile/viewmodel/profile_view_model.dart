import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/base/viewmodels/base_view_model.dart';
import 'package:flutter_fake_api/models/crypto_model.dart';
import 'package:flutter_fake_api/screens/home/view/profile/profile_service.dart';

import '../../../../../components/alert_dialog.dart';

class ProfileViewModel extends BaseViewModel{
  final ProfileService service;
  List<CryptoModel> _cryptos= [];
  String? fullName;

  ProfileViewModel({required this.service});


  @override
  FutureOr<void> init()async {
    await getFavoritesCryptosData();
  }

  Future<void> signOut(BuildContext context)async{
    isLoading = true;

    var response = await service.signOutMethod();
    showMyDialog(context, response.errorMessage);
    isLoading = false;
  }


  Future<void> getFavoritesCryptosData()async{
    isLoading = true;
    try{
      var response = await service.getFavoritesData();
      if(response.isSucces){
        _cryptos = (response.data as  List<QueryDocumentSnapshot<Map<String, dynamic>>>).map((e) => CryptoModel.fromMap(e.data()),).toList();
      }
      else{
        debugPrint(response.errorMessage);
      }

    }
    catch(e){
      debugPrint(e.toString());
    }
    finally{
      isLoading = false;
    }
  }

  List<CryptoModel> get cryptos => _cryptos;
}