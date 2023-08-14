import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../localization/global_translation.dart';
import '../../localization/preferences.dart';

part 'translation_event.dart';
part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationBloc(TranslationState initialState) : super(initialState) {
    on<SwitchLanguage>((event, emit) async {
      print(event.language);
      await preferences.setPreferredLanguage(event.language);
      // Notification the translations module about the new language
      await translations.setNewLanguage(event.language);
      emit(TranslationState(
        locale: translations.locale,
      ));
    });
  }

  TranslationState get initialState => TranslationState(
        locale: translations.locale,
      );
}
