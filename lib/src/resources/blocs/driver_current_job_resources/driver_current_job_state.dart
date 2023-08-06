part of 'driver_current_job_bloc.dart';

@immutable
abstract class DriverCurrentJobState {}

class DriverCurrentJobInitial extends DriverCurrentJobState {}

class DriverCurrentJobLoading extends DriverCurrentJobState {}

class DriverCurrentJobAccepted extends DriverCurrentJobState {
  DriverCurrentJobAccepted({required this.currentWorkingOrder});
  final Emergency currentWorkingOrder;
}
