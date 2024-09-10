import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fake_api/base/services/network_service.dart';

import '../../../models/user_model.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/sharred_preferences_utils.dart';

class SignupService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<NetworkResponseServices> registerWithEmailAndPassword(UserModel user,String password)async{
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
      await  _firestore.collection('myUsers').doc(userCredential.user!.uid).set(user.toJson(key: userCredential.user!.uid));
      SharedPreferencesUtil().setEmail(user.email);
      SharedPreferencesUtil().setFullName(user.fullName);
      SharedPreferencesUtil().setUserId(userCredential.user?.uid ?? user.userId);
      SharedPreferencesUtil().setBalance(user.balance);
      return NetworkResponseServices(isSucces: true,data: null, errorMessage: LocaleKeys.progressSuccess);
    }
    catch(e){
      return NetworkResponseServices(isSucces: false,data: null, errorMessage: LocaleKeys.progressNotSuccess);
    }
  }
}