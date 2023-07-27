part of 'ambulance_bloc.dart';

@immutable
abstract class AmbulanceState {}

class AmbulanceInitial extends AmbulanceState {}

class AmbulanceLoading extends AmbulanceState {}

class AmbulanceAdded extends AmbulanceState {}

class AmbulanceDeleted extends AmbulanceState {}
