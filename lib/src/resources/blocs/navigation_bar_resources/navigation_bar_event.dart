part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarEvent {}

class SetNavigationBarToInitial extends NavigationBarEvent {}

class ChangeScreenInNavigationBar extends NavigationBarEvent {
  ChangeScreenInNavigationBar({
    required this.indexOfItem,
    required this.role,
  });
  final int indexOfItem;
  final String role;
}
