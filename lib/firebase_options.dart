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
    apiKey: 'AIzaSyC6mKJyHuUWU9u2RETWf_3H1wwnFO87nDc',
    appId: '1:916836963557:web:5598ddcaa0f62d5a56300c',
    messagingSenderId: '916836963557',
    projectId: 'l-movie-11f63',
    authDomain: 'l-movie-11f63.firebaseapp.com',
    storageBucket: 'l-movie-11f63.appspot.com',
    measurementId: 'G-95KX2ZB4G1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAm8D9SwCJmAEPZeMcZPAbnbOGt9s0SXW8',
    appId: '1:916836963557:android:d59b1bff33796ea656300c',
    messagingSenderId: '916836963557',
    projectId: 'l-movie-11f63',
    storageBucket: 'l-movie-11f63.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAezqGTcPJGibFz7UcTSPRt9n-pKCi2DV0',
    appId: '1:916836963557:ios:fb6ca4c75a7dbccd56300c',
    messagingSenderId: '916836963557',
    projectId: 'l-movie-11f63',
    storageBucket: 'l-movie-11f63.appspot.com',
    iosClientId: '916836963557-sa36uasuehkqnk2d7cdpnrms3astm93l.apps.googleusercontent.com',
    iosBundleId: 'com.thenglong.lMovie',
  );
}