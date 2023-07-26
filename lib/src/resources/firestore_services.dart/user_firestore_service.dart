import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class UserFirestoreService {
  final String collectionName = 'User';

  Future<User?> addUser({
    required String phoneNumber,
    required String userRole,
    Map<dynamic, dynamic>? userData,
  }) async {
    print("UserFirestoreService: addUser Function");
    User? user;
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where('phoneNumberRoleKey', isEqualTo: phoneNumber + userRole)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print("userFound");
          Map<String, dynamic> userMap = {
            'id': doc['id'],
            'role': doc['role'],
            'phoneNumber': doc['phoneNumber'],
            'phoneNumberRoleKey': doc['phoneNumberRoleKey'],
          };

          user = User.fromJson(userMap);
        });
      });

      if (user != null) {
        return user;
      } else {
        final String userId = const Uuid().v1();
        // DateTime.now().toIso8601String() + Storage.getValue("UserEmail");
        try {
          final Map<String, dynamic> userMap = {
            'id': userId,
            'role': userRole,
            'phoneNuber': phoneNumber,
            'phoneNumberRoleKey': phoneNumber + userRole
          };
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(userId)
              .set(userMap)
              .catchError((e) {
            print(e.toString());
            throw e.toString();
          });
          user = User.fromJson(userMap);
          return user;
        } catch (e) {
          throw e.toString();
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
