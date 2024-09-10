import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/components/alert_dialog.dart';

import '../../../base/viewmodels/base_view_model.dart';
import '../../../models/crypto_model.dart';
import '../followedby_service.dart';

class FollowedByViewModel extends BaseViewModel{
  FollowedByViewService service;
  List<CryptoModel> _followedCryptos = [];


  FollowedByViewModel({required this.service});



  @override
  FutureOr<void> init() async{
        await getFavoritesCryptosData();
  }

  Future<void> getFavoritesCryptosData()async{
    isLoading = true;
    try{
      var response = await service.getFavoritesData();
      if(response.isSucces){
        _followedCryptos = (response.data as  List<QueryDocumentSnapshot<Map<String, dynamic>>>).map((e) => CryptoModel.fromMap(e.data()),).toList();
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


  Future<void> deleteFollowedList(CryptoModel crypto,BuildContext context)async{
    isLoading = true;
    try{
      await service.deleteFavorites(crypto);
      await getFavoritesCryptosData();
      reloadState();
    }
    catch(e){
      showMyDialog(context, e.toString());
    }
    finally{
      isLoading = false;
    }
  }

  List<CryptoModel> get followedCryptos => _followedCryptos;
}

