import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user_model.dart';
import '../../base/services/network_response_services.dart';
import '../../utils/sharredpref_util.dart';

class SignupService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<NetworkResponseServices> registerWithEmailAndPassword(UserModel user,String password)async{
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
      await  _firestore.collection('bookUsers').doc(userCredential.user!.uid).set(user.toJson(key: userCredential.user!.uid));
      SharedPreferencesUtil().setEmail(user.email);
      SharedPreferencesUtil().setFullName(user.fullName);
      SharedPreferencesUtil().setUserId(userCredential.user?.uid ?? user.userId);
      return NetworkResponseServices(isSucces: true,data: null, errorMessage: "başarılı");
    }
    catch(e){
      return NetworkResponseServices(isSucces: false,data: null, errorMessage: e.toString());
    }
  }
}