part of 'ambulance_bloc.dart';

@immutable
abstract class AmbulanceEvent {}

class AddAmbulance extends AmbulanceEvent {
  AddAmbulance({
    required this.plateNumber,
    required this.vehicleImage,
    required this.registrationImage,
    required this.equipped,
    required this.size,
  });
  final String plateNumber;
  final String vehicleImage;
  final String registrationImage;
  final String equipped;
  final String size;
}

class DeleteAmbulance extends AmbulanceEvent {
  DeleteAmbulance({
    required this.plateNumber,
  });
  final String plateNumber;
}

class SetAmbulanceBlocToInitial extends AmbulanceEvent {}
