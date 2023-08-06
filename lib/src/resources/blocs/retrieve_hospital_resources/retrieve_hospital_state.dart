part of 'retrieve_hospital_bloc.dart';

@immutable
abstract class RetrieveHospitalState {}

class RetrieveHospitalInitial extends RetrieveHospitalState {}

class RetrievingHospitals extends RetrieveHospitalState {}

class RetrievedAllHospitals extends RetrieveHospitalState {
  RetrievedAllHospitals({required this.allHospitalsList});
  final List<Hospital> allHospitalsList;
}
