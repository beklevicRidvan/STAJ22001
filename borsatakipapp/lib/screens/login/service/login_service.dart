import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fake_api/base/services/network_service.dart';

import '../../../translations/locale_keys.g.dart';

class LoginService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<NetworkResponseServices> signIn(String email,String password)async{

    try{
      var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      var currentUser = await _firestore.collection('myUsers').doc(userCredential.user!.uid).get();
      await _firestore.collection('myUsers').doc(userCredential.user!.uid).set({
        'lastLogged':Timestamp.now(),
      },SetOptions(merge: true));
      return NetworkResponseServices(isSucces: true,data:currentUser.data(), errorMessage: LocaleKeys.progressSuccess);
    }
    catch(e){
      return NetworkResponseServices(isSucces: false,data: null, errorMessage: e.toString());
    }

  }

}