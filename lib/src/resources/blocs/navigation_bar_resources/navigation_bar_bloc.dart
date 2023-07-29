import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc() : super(NavigationBarInitial()) {
    on<SetNavigationBarToInitial>((event, emit) {
      emit(NavigationBarInitial());
    });
    on<ChangeScreenInNavigationBar>((event, emit) {
      emit(NavigationBarLoaded(
        indexOfItem: event.indexOfItem,
        role: event.role,
      ));
    });
  }
}
