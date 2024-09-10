import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fake_api/base/services/firebase_service.dart';
import 'package:flutter_fake_api/models/crypto_model.dart';
import 'package:flutter_fake_api/models/my_crypto_model.dart';
import 'package:flutter_fake_api/translations/locale_keys.g.dart';
import 'package:flutter_fake_api/utils/extension_utils.dart';

class MyCryptosScreenService{
  Future<List<MyCryptoModel>> getDatas() async {
    List<MyCryptoModel> myCryptoModel = [];
    User? currentUser = FirebaseService.firebaseAuth.currentUser;

    if (currentUser == null) {
      throw Exception(LocaleKeys.userEmptyError.locale);
    }

    try {
      var myCryptoCollectionRef = await FirebaseService.firebaseFirestore
          .collection("myUsers")
          .doc(currentUser.uid)
          .collection("cryptos")
          .get();
      var myCryptoDocs = myCryptoCollectionRef.docs;

      if (myCryptoDocs.isEmpty) {
        return myCryptoModel;
      }


      var cryptoIds = myCryptoDocs.map((e) => e.data()['cryptoId'] as String).toList();

      var allCryptosCollectionRef = await FirebaseService.firebaseFirestore
          .collection("coins")
          .where(FieldPath.documentId, whereIn: cryptoIds)
          .get();
      var allCryptosDocs = allCryptosCollectionRef.docs;

      for (var cryptosDoc in allCryptosDocs) {
        var userCryptoDoc = myCryptoDocs.firstWhere((doc) => doc.data()['cryptoId'] == cryptosDoc.id);
        myCryptoModel.add(MyCryptoModel.fromMap(
          userCryptoDoc.data(),
          CryptoModel.fromMap(cryptosDoc.data()),
        ));
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return myCryptoModel;
  }

  Future<void> sellCrypto(String cryptoId,double totalPrice)async{
    User? currentUser = FirebaseService.firebaseAuth.currentUser;
    if(currentUser == null){
      throw Exception(LocaleKeys.userEmptyError.locale);
    }
    try{
      await FirebaseService.firebaseFirestore.collection("myUsers").doc(currentUser.uid).collection("cryptos").doc(cryptoId).delete();
      await FirebaseService.firebaseFirestore.collection("myUsers").doc(currentUser.uid).update({
        "balance":FieldValue.increment(totalPrice)
      });
      
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
}