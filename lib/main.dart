import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/resources/blocs/translation_resources/translation_bloc.dart';
import 'src/resources/localization/global_translation.dart';

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

  List<String> supportedLanguages = ['en', 'ur'];
  Map<String, String> supportedLanguagesMapOfNames = {
    'en': 'English',
    'ur': 'اردو',
  };
  await translations.init(
    supportedLanguages,
    supportedLanguagesMapOfNames: supportedLanguagesMapOfNames,
    fallbackLanguage: 'en',
  );
  runApp(BlocProvider(
    create: (context) => TranslationBloc(
      TranslationState(locale: translations.locale),
    ),
    child: const App(),
  ));
}
