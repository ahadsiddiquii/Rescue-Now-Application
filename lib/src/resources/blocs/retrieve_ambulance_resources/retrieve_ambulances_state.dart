part of 'retrieve_ambulances_bloc.dart';

@immutable
abstract class RetrieveAmbulancesState {}

class RetrieveAmbulancesInitial extends RetrieveAmbulancesState {}

class RetrievingAmbulances extends RetrieveAmbulancesState {}

class RetrievedAllAmbulances extends RetrieveAmbulancesState {
  RetrievedAllAmbulances({required this.allAmbulanceList});
  final List<Ambulance> allAmbulanceList;
}
