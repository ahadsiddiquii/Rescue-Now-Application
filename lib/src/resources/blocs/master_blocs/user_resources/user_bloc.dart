import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<CheckIfLoggedIn>((
      CheckIfLoggedIn event,
      Emitter<UserState> emit,
    ) async {
      await Future.delayed(Duration(seconds: 5));
      emit(UserInitial());
    });
  }
}
