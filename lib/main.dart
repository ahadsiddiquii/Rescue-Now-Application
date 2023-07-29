import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  // ignore: always_specify_types
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  if (Firebase.apps.isNotEmpty) {
    print('Firebase is initialized');
  } else {
    print('Firebase is not initialized');
  }
  runApp(const App());
}
