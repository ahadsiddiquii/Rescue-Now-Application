part of 'translation_bloc.dart';

@immutable
abstract class TranslationEvent {}

class SwitchLanguage extends TranslationEvent {
  SwitchLanguage({required this.language});
  final String language;
}
