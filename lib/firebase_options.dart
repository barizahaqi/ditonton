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
    apiKey: 'AIzaSyC5cpAiRws1bWSrtijZcd5C-cOAp9NWApo',
    appId: '1:79705791988:web:d272fd779aefc9162beda1',
    messagingSenderId: '79705791988',
    projectId: 'ditonton-e592e',
    authDomain: 'ditonton-e592e.firebaseapp.com',
    storageBucket: 'ditonton-e592e.appspot.com',
    measurementId: 'G-V24HSE87FQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCni3mhpKVFB8FwPG-7D5nV8q4JS0rN2I',
    appId: '1:79705791988:android:c670edce0b30f5e22beda1',
    messagingSenderId: '79705791988',
    projectId: 'ditonton-e592e',
    storageBucket: 'ditonton-e592e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxOboVFfSrKWzrqikK0etlalAoqdaLYnY',
    appId: '1:79705791988:ios:26bbfaab715ce2af2beda1',
    messagingSenderId: '79705791988',
    projectId: 'ditonton-e592e',
    storageBucket: 'ditonton-e592e.appspot.com',
    iosClientId: '79705791988-en9gvenrjgocc72k99lqgmlsp7v2v2c4.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}