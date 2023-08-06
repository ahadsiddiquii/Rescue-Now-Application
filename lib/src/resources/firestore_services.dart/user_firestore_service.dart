import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class UserFirestoreService {
  final String collectionName = 'User';

  Future<User?> loginUser({
    required String phoneNumber,
    required String userRole,
  }) async {
    print('UserFirestoreService: loginUser Function');
    User? user;
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where('phoneNumberRoleKey', isEqualTo: phoneNumber + userRole)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          print('userFound');

          Map<String, dynamic> userMap = {
            'id': doc['id'],
            'role': doc['role'],
            'phoneNumber': doc['phoneNumber'],
            'phoneNumberRoleKey': doc['phoneNumberRoleKey'],
          };
          if (userRole == 'Customer') {
            userMap.addEntries(
              {
                'fullName': doc['fullName'],
                'email': doc['email'],
              }.entries,
            );
          }
          if (userRole == 'Driver') {
            userMap.addEntries(
              {
                'fullName': doc['fullName'],
              }.entries,
            );
          }

          user = User.fromJson(userMap);
        }
      });
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> addUser({
    required String phoneNumber,
    required String userRole,
    Map<String, dynamic>? userData,
  }) async {
    print('UserFirestoreService: addUser Function');
    User? user;
    try {
      final String userId = const Uuid().v1();
      // DateTime.now().toIso8601String() + Storage.getValue("UserEmail");
      try {
        final Map<String, dynamic> userMap = {
          'id': userId,
          'role': userRole,
          'phoneNumber': phoneNumber,
          'phoneNumberRoleKey': phoneNumber + userRole
        };
        if (userData != null) {
          userMap.addAll(userData);
        }

        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .set(userMap)
            .catchError((e) {
          print(e);
          throw e.toString();
        });
        user = User.fromJson(userMap);
        return user;
      } catch (e) {
        throw e.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
