// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBg6EFZrIcut1YureB7VwUZt_q850za6nM',
    appId: '1:131046516398:web:34d1d07be3aa170a63ef3f',
    messagingSenderId: '131046516398',
    projectId: 'ditonton-524bd',
    authDomain: 'ditonton-524bd.firebaseapp.com',
    storageBucket: 'ditonton-524bd.appspot.com',
    measurementId: 'G-0TT6JHB1Y6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmM4Yo9JpMOuJ15Mowa_Zdm1FptA4OBR0',
    appId: '1:131046516398:android:5e9835f5ff368a2c63ef3f',
    messagingSenderId: '131046516398',
    projectId: 'ditonton-524bd',
    storageBucket: 'ditonton-524bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuq6umerV1nJqc3_kFqXP5Y0SZpklJWrA',
    appId: '1:131046516398:ios:578aeab4becbf6e063ef3f',
    messagingSenderId: '131046516398',
    projectId: 'ditonton-524bd',
    storageBucket: 'ditonton-524bd.appspot.com',
    iosClientId: '131046516398-mvbgjd1ji72vonjvjfg2kak8ou3nhaai.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}