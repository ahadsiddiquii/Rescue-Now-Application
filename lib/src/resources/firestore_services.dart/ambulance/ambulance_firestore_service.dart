import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../models/ambulance.dart';

class AmbulanceFirestoreService {
  final String collectionName = 'Ambulance';

  Future<bool> addAmbulance({
    required String plateNumber,
    required String vehicleImage,
    required String registrationImage,
  }) async {
    print('AmbulanceFirestoreService: addAmbulance Function');
    bool vehicleAlreadyExists = false;
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where('plateNumber', isEqualTo: plateNumber)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          print('Vehicle with the plate number found');
          vehicleAlreadyExists = true;
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Vehicle with this plate number exists',
          );
        }
      });
      if (vehicleAlreadyExists) {
        return false;
      } else {
        final Map<String, dynamic> userMap = {
          'plateNumber': plateNumber,
          'vehicleFrontImage': vehicleImage,
          'vehicleRegistrationImage': registrationImage,
        };

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(plateNumber)
            .set(userMap)
            .catchError((e) {
          print(e);
          throw e.toString();
        });

        return true;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Ambulance>> getAllAmbulances() async {
    print('AmbulanceFirestoreService: getAllAmbulances Function');
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      final QuerySnapshot querySnapshot = await collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<Ambulance> allAmbulances = [];
      for (final item in allData) {
        final singleAmbulance = item as Map<String, dynamic>;

        allAmbulances.add(Ambulance.fromJson(singleAmbulance));
      }
      print('allAmbulances: ${allAmbulances.length}');
      return allAmbulances;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteAmbulance(String plateNumber) async {
    print('AmbulanceFirestoreService: deleteGoal Function');
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(plateNumber)
          .delete();

      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
