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
        return macos;
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
    apiKey: 'AIzaSyAwnoS9qXDQrfVl2qDK5wX0rtaOZlVciNE',
    appId: '1:170926163038:web:12dffc607d9e22a855e0cf',
    messagingSenderId: '170926163038',
    projectId: 'octobus-bus-project',
    authDomain: 'octobus-bus-project.firebaseapp.com',
    storageBucket: 'octobus-bus-project.appspot.com',
    measurementId: 'G-16L5DQYXX0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCO0UdhNK-_QJzh0HGlWheFfB8mEmQwads',
    appId: '1:170926163038:android:76597f07969e1d3c55e0cf',
    messagingSenderId: '170926163038',
    projectId: 'octobus-bus-project',
    storageBucket: 'octobus-bus-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtcGMEVxrGTdeh8qj3lqEdZ7WDbSn3JoI',
    appId: '1:170926163038:ios:aa500b169d7ddefb55e0cf',
    messagingSenderId: '170926163038',
    projectId: 'octobus-bus-project',
    storageBucket: 'octobus-bus-project.appspot.com',
    iosClientId: '170926163038-mii7jr3dhjgks00bgb1prl7942jdaiec.apps.googleusercontent.com',
    iosBundleId: 'com.example.octobus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtcGMEVxrGTdeh8qj3lqEdZ7WDbSn3JoI',
    appId: '1:170926163038:ios:aa500b169d7ddefb55e0cf',
    messagingSenderId: '170926163038',
    projectId: 'octobus-bus-project',
    storageBucket: 'octobus-bus-project.appspot.com',
    iosClientId: '170926163038-mii7jr3dhjgks00bgb1prl7942jdaiec.apps.googleusercontent.com',
    iosBundleId: 'com.example.octobus',
  );
}
