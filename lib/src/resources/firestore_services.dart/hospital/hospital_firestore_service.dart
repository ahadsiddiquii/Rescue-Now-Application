import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../models/hospital.dart';

class HospitalFirestoreService {
  final String collectionName = 'Hospital';

  Future<bool> addHospital({
    required String placeName,
    required double placeLatitude,
    required double placeLongitude,
  }) async {
    print('HospitalFirestoreService: addHospital Function');
    final String hospitalId = const Uuid().v1();
    try {
      final Map<String, dynamic> hospitalMap = {
        'hospitalId': hospitalId,
        'placeName': placeName,
        'placeLatitude': placeLatitude,
        'placeLongitude': placeLongitude,
      };

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(hospitalId)
          .set(hospitalMap)
          .catchError((e) {
        print(e);
        throw e.toString();
      });

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Hospital>> getAllHospitals() async {
    print('HospitalFirestoreService: getAllAmbulances Function');
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      final QuerySnapshot querySnapshot = await collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<Hospital> allHospitals = [];
      for (final item in allData) {
        final singleHospital = item as Map<String, dynamic>;

        allHospitals.add(Hospital.fromJson(singleHospital));
      }
      print('allHospitals: ${allHospitals.length}');
      return allHospitals;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteHospital(String hospitalId) async {
    print('HospitalFirestoreService: deleteHospital Function');
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(hospitalId)
          .delete();

      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
