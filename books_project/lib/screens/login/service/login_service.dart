import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../base/services/network_response_services.dart';


class LoginService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<NetworkResponseServices> signIn(String email,String password)async{

    try{
      var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      var currentUser = await _firestore.collection('bookUsers').doc(userCredential.user!.uid).get();
      await _firestore.collection('bookUsers').doc(userCredential.user!.uid).set({
        'lastLogged':Timestamp.now(),
      },SetOptions(merge: true));
      return NetworkResponseServices(isSucces: true,data:currentUser.data(), errorMessage: "başarılı");
    }
    catch(e){
      return NetworkResponseServices(isSucces: false,data: null, errorMessage: e.toString());
    }

  }

}