part of 'hospital_bloc.dart';

@immutable
abstract class HospitalEvent {}

class AddHospital extends HospitalEvent {
  AddHospital({
    required this.placeName,
    required this.placeLatitude,
    required this.placeLongitude,
  });
  final String placeName;
  final double placeLatitude;
  final double placeLongitude;
}

class DeleteHospital extends HospitalEvent {
  DeleteHospital({
    required this.hospitalId,
  });
  final String hospitalId;
}

class SetHospitalBlocToInitial extends HospitalEvent {}
