part of 'hospital_bloc.dart';

@immutable
abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalAdded extends HospitalState {}

class HospitalDeleted extends HospitalState {}
