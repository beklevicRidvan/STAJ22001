import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../base/services/firebase_service.dart';
import '../../base/services/network_service.dart';
import '../../models/crypto_model.dart';
import '../../translations/locale_keys.g.dart';

class FollowedByViewService {

  Future<NetworkResponseServices> getFavoritesData() async {
    User? user = FirebaseService.firebaseAuth.currentUser;
    try {
      if (user != null) {
        var favoriteCollectionRef = await FirebaseService.firebaseFirestore.collection('myUsers').doc(user.uid).collection('favorites').get();
        List<String> cryptoIds = favoriteCollectionRef.docs
            .map(
              (e) => e.id,
        )
            .toList();


        var filteredFavoireCryptosCollectionRef = await FirebaseService.firebaseFirestore.collection('coins').where(FieldPath.documentId,whereIn: cryptoIds).get();
        debugPrint(cryptoIds.toString());
        return NetworkResponseServices(isSucces: true, data: filteredFavoireCryptosCollectionRef.docs, errorMessage: LocaleKeys.progressSuccess);
      } else {
        return NetworkResponseServices(isSucces: false, data: null, errorMessage: LocaleKeys.userEmptyError);
      }
    } catch (e) {
      return NetworkResponseServices(isSucces: false, data: null, errorMessage: e.toString());
    }


  }

  Future<void> deleteFavorites(CryptoModel cryptoModel) async{
    try{
      User? user = FirebaseService.firebaseAuth.currentUser;
      if (user != null) {
        await FirebaseService.firebaseFirestore
            .collection('myUsers')
            .doc(user.uid)
            .collection('favorites')
            .doc(cryptoModel.coinId).delete();
      }
      else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
}