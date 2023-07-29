part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarState {}

class NavigationBarInitial extends NavigationBarState {}

class NavigationBarLoaded extends NavigationBarState {
  NavigationBarLoaded({
    required this.indexOfItem,
    required this.role,
  });
  final int indexOfItem;
  final String role;
}
