part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class CheckIfLoggedIn extends UserEvent {}

class LoginOrRegister extends UserEvent {
  LoginOrRegister({
    required this.phoneNumber,
    required this.userRole,
  });
  final String phoneNumber;
  final String userRole;
}
