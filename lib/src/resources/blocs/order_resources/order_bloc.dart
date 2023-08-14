import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/hospital/hospital_firestore_service.dart';
import '../../firestore_services.dart/order/order_firestore_service.dart';
import '../../google_maps_helper.dart';
import '../../models/hospital.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();
    final HospitalFirestoreService hospitalFirestoreService =
        HospitalFirestoreService();
    on<InsertEmergencyOrder>((event, emit) async {
      try {
        emit(OrderLoading());
        LatLng? userCurrentLocation =
            await GoogleMapsUserLocationHelper.getUserCurrentLocation();
        if (userCurrentLocation == null) {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Error getting user location',
          );
          emit(OrderInitial());
        } else {
          final List<Hospital> allHospitals =
              await hospitalFirestoreService.getAllHospitals();
          double closestHospitalDistance = 9999999;
          Hospital? goingToHospital;
          for (final hospital in allHospitals) {
            final double currentHospitalDistance =
                GoogleMapsUserLocationHelper.calculateDistance(
                    userCurrentLocation.latitude,
                    userCurrentLocation.longitude,
                    hospital.placeLatitude,
                    hospital.placeLongitude);
            if (currentHospitalDistance < closestHospitalDistance) {
              closestHospitalDistance = currentHospitalDistance;
              goingToHospital = hospital;
            }
          }
          if (goingToHospital != null) {
            final bool isOrderAdded = await orderFirestoreService.insertOrder(
              emergencyLevel: event.emergencyLevel,
              reason: event.stress,
              pickUpLat: userCurrentLocation.latitude,
              pickUpLong: userCurrentLocation.longitude,
              hospitalName: goingToHospital.placeName,
              preferredAmbulanceSize: event.ambulanceSize,
              preferredAmbulanceEquipment: event.ambulanceEquipment,
              dropOffLat: goingToHospital.placeLatitude,
              dropoffLong: goingToHospital.placeLongitude,
              customerId: event.customerId,
            );
            if (isOrderAdded) {
              CustomSnackBar.snackBarTrigger(
                context: AppContextManager.getAppContext(),
                message: 'Ambulance will soon reach out to you Be safe',
              );
              emit(OrderAdded());
            } else {
              CustomSnackBar.snackBarTrigger(
                context: AppContextManager.getAppContext(),
                message: CustomExceptionHandler.getError500(),
              );
              emit(OrderInitial());
            }
          } else {
            CustomSnackBar.snackBarTrigger(
              context: AppContextManager.getAppContext(),
              message: 'Could not find any hospitals nearby',
            );
            emit(OrderInitial());
          }
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(OrderInitial());
      }
    });
    on<InsertNormalOrder>((event, emit) async {
      try {
        emit(OrderLoading());

        final bool isOrderAdded = await orderFirestoreService.insertOrder(
          emergencyLevel: event.emergencyLevel,
          reason: event.stress,
          pickUpLat: event.currentLat,
          pickUpLong: event.currentLong,
          hospitalName: event.hospital.placeName,
          preferredAmbulanceSize: event.ambulanceSize,
          preferredAmbulanceEquipment: event.ambulanceEquipped,
          dropOffLat: event.hospital.placeLatitude,
          dropoffLong: event.hospital.placeLongitude,
          customerId: event.customerId,
        );
        if (isOrderAdded) {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Ambulance will soon reach out to you Be safe',
          );
          emit(OrderAdded());
        } else {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: CustomExceptionHandler.getError500(),
          );
          emit(OrderInitial());
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(OrderInitial());
      }
    });
    on<SetOrderBlocToInitial>((event, emit) async {
      emit(OrderInitial());
    });
  }
}
