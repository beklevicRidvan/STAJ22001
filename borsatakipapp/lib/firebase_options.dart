// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCV1gs78Y5Scmd_THH92EihurrywqKcJBA',
    appId: '1:536312548303:web:06f1d9009a7b51b4a4a0ba',
    messagingSenderId: '536312548303',
    projectId: 'firestore-uygulamalari',
    authDomain: 'firestore-uygulamalari.firebaseapp.com',
    databaseURL: 'https://firestore-uygulamalari-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'firestore-uygulamalari.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTAT0slxIbnw8x7oWjef47x8OGnn6zWQo',
    appId: '1:536312548303:android:2f4bd6ea7242d2b9a4a0ba',
    messagingSenderId: '536312548303',
    projectId: 'firestore-uygulamalari',
    databaseURL: 'https://firestore-uygulamalari-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'firestore-uygulamalari.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3SzLbcmLzHuuc_OJ9kj4-LjHmoTHQGvU',
    appId: '1:536312548303:ios:bb56c30cb43438c9a4a0ba',
    messagingSenderId: '536312548303',
    projectId: 'firestore-uygulamalari',
    databaseURL: 'https://firestore-uygulamalari-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'firestore-uygulamalari.appspot.com',
    iosBundleId: 'com.example.flutterFakeApi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3SzLbcmLzHuuc_OJ9kj4-LjHmoTHQGvU',
    appId: '1:536312548303:ios:bb56c30cb43438c9a4a0ba',
    messagingSenderId: '536312548303',
    projectId: 'firestore-uygulamalari',
    databaseURL: 'https://firestore-uygulamalari-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'firestore-uygulamalari.appspot.com',
    iosBundleId: 'com.example.flutterFakeApi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCV1gs78Y5Scmd_THH92EihurrywqKcJBA',
    appId: '1:536312548303:web:90a60163cf0769eda4a0ba',
    messagingSenderId: '536312548303',
    projectId: 'firestore-uygulamalari',
    authDomain: 'firestore-uygulamalari.firebaseapp.com',
    databaseURL: 'https://firestore-uygulamalari-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'firestore-uygulamalari.appspot.com',
  );
}
