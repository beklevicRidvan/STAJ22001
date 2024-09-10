import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fake_api/base/services/firebase_service.dart';
import 'package:flutter_fake_api/models/crypto_model.dart';

import '../../translations/locale_keys.g.dart';

class CryptoDetailService {
  Future<void> addMyCryptos(CryptoModel crypto, double piece) async {
    User? user = FirebaseService.firebaseAuth.currentUser;
    try {
      if (user != null) {
        var userCollectionRef = await FirebaseService.firebaseFirestore.collection("myUsers").doc(user.uid).get();
        double balance = userCollectionRef.data()!["balance"];
        if (balance > crypto.price * piece) {
          await FirebaseService.firebaseFirestore
              .collection("myUsers")
              .doc(user.uid)
              .update({"balance": FieldValue.increment(-(piece * crypto.price))});
        } else {
          throw Exception("YETERLİ BAKİYENİZ BULUNMUYOR");
        }
        await FirebaseService.firebaseFirestore.collection('myUsers').doc(user.uid).collection('cryptos').doc(crypto.coinId).set(
            {'cryptoId': crypto.coinId, 'piece': FieldValue.increment(piece), 'totalPrice': FieldValue.increment(piece * crypto.price)},
            SetOptions(merge: true));
      } else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addFavorites(CryptoModel crypto) async {
    try {
      User? user = FirebaseService.firebaseAuth.currentUser;
      if (user != null) {
        await FirebaseService.firebaseFirestore
            .collection('myUsers')
            .doc(user.uid)
            .collection('favorites')
            .doc(crypto.coinId)
            .set(crypto.toMap(crypto.coinId));
      } else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> isFavorited(CryptoModel crypto) async {
    try {
      User? user = FirebaseService.firebaseAuth.currentUser;
      if (user != null) {
        var favoriteDoc =
            await FirebaseService.firebaseFirestore.collection('myUsers').doc(user.uid).collection('favorites').doc(crypto.coinId).get();
        return favoriteDoc.exists;
      } else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteFavorites(CryptoModel cryptoModel) async {
    try {
      User? user = FirebaseService.firebaseAuth.currentUser;
      if (user != null) {
        await FirebaseService.firebaseFirestore.collection('myUsers').doc(user.uid).collection('favorites').doc(cryptoModel.coinId).delete();
      } else {
        throw Exception(LocaleKeys.userEmptyError);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
