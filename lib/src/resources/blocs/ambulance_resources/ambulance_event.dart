part of 'ambulance_bloc.dart';

@immutable
abstract class AmbulanceEvent {}

class AddAmbulance extends AmbulanceEvent {
  AddAmbulance({
    required this.plateNumber,
    required this.vehicleImage,
    required this.registrationImage,
  });
  final String plateNumber;
  final String vehicleImage;
  final String registrationImage;
}

class DeleteAmbulance extends AmbulanceEvent {
  DeleteAmbulance({
    required this.plateNumber,
  });
  final String plateNumber;
}
