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
    apiKey: 'AIzaSyBGTl3M_gPHF6uGfabbcW3zb_ToTCy703o',
    appId: '1:873615524458:web:20de605b7743c75277c013',
    messagingSenderId: '873615524458',
    projectId: 'ewaste-89269',
    authDomain: 'ewaste-89269.firebaseapp.com',
    storageBucket: 'ewaste-89269.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdbbIiJz0fmK0nkk-JoQW616GQu_ITJB8',
    appId: '1:873615524458:android:717e84e7b357c35877c013',
    messagingSenderId: '873615524458',
    projectId: 'ewaste-89269',
    storageBucket: 'ewaste-89269.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLFDW1JLUHUItHk8U6hxouLJcXUm1EuhA',
    appId: '1:873615524458:ios:a7e6fdb5e2eb8eab77c013',
    messagingSenderId: '873615524458',
    projectId: 'ewaste-89269',
    storageBucket: 'ewaste-89269.appspot.com',
    iosBundleId: 'com.example.ewaste',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLFDW1JLUHUItHk8U6hxouLJcXUm1EuhA',
    appId: '1:873615524458:ios:a7e6fdb5e2eb8eab77c013',
    messagingSenderId: '873615524458',
    projectId: 'ewaste-89269',
    storageBucket: 'ewaste-89269.appspot.com',
    iosBundleId: 'com.example.ewaste',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBGTl3M_gPHF6uGfabbcW3zb_ToTCy703o',
    appId: '1:873615524458:web:5740a0e5c4b26dcc77c013',
    messagingSenderId: '873615524458',
    projectId: 'ewaste-89269',
    authDomain: 'ewaste-89269.firebaseapp.com',
    storageBucket: 'ewaste-89269.appspot.com',
  );
}
