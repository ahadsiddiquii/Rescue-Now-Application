part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class CheckIfLoggedIn extends UserEvent {}

class LoginOrRegister extends UserEvent {
  LoginOrRegister({
    required this.phoneNumber,
    required this.userRole,
    this.userData,
  });
  final String phoneNumber;
  final String userRole;
  final Map<String, dynamic>? userData;
}

class ResetStateToUserInitial extends UserEvent {}

class MakeUserLoad extends UserEvent {}

class MakeUserLoggedIn extends UserEvent {
  MakeUserLoggedIn({
    required this.user,
  });
  final User user;
}
