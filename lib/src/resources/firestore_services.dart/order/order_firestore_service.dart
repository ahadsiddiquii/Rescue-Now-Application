import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../models/order.dart';

class OrderFirestoreService {
  final String collectionName = 'Order';

  Future<bool> insertOrder({
    required String emergencyLevel,
    required String reason,
    required double pickUpLat,
    required double pickUpLong,
    required String hospitalName,
    required double dropOffLat,
    required double dropoffLong,
    required String customerId,
  }) async {
    print('OrderFirestoreService: insertOrder Function');
    final String orderId = const Uuid().v1();
    try {
      final Map<String, dynamic> orderMap = {
        'customerId': customerId,
        'orderId': orderId,
        'isAccepted': false,
        'emergencyLevel': emergencyLevel,
        'reason': reason,
        'pickUpLat': pickUpLat,
        'pickUpLong': pickUpLong,
        'hospitalName': hospitalName,
        'dropOffLat': dropOffLat,
        'dropoffLong': dropoffLong,
        'job': null
      };

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(orderId)
          .set(orderMap)
          .catchError((e) {
        print(e);
        throw e.toString();
      });

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Emergency>> getAllUnacceptedOrders() async {
    print('OrderFirestoreService: getAllUnacceptedOrders Function');
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      final QuerySnapshot querySnapshot = await collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<Emergency> allOrders = [];
      for (final item in allData) {
        final singleOrder = item as Map<String, dynamic>;
        if (item['isAccepted'] == false) {
          allOrders.add(Emergency.fromJson(singleOrder));
        }
      }
      print('allOrders: ${allOrders.length}');
      return allOrders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Emergency>> getAllCustomerOrders({required String userId}) async {
    print('OrderFirestoreService: getAllCustomerOrders Function');
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      final QuerySnapshot querySnapshot = await collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<Emergency> allOrders = [];
      for (final item in allData) {
        final singleOrder = item as Map<String, dynamic>;
        if (userId == item['customerId']) {
          allOrders.add(Emergency.fromJson(singleOrder));
        }
      }
      print('allOrders: ${allOrders.length}');
      return allOrders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Emergency>> getAllDriverOrders({required String userId}) async {
    print('OrderFirestoreService: getAllDriverOrders Function');
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      final QuerySnapshot querySnapshot = await collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<Emergency> allOrders = [];
      for (final item in allData) {
        final singleOrder = item as Map<String, dynamic>;
        if (item['isAccepted'] == true) {
          if (userId == item['job']['driverId']) {
            allOrders.add(Emergency.fromJson(singleOrder));
          }
        }
      }
      print('allDriverOrders: ${allOrders.length}');
      return allOrders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Emergency> acceptJob({
    required Emergency acceptedOrder,
    required String driverId,
  }) async {
    print('OrderFirestoreService: acceptJob Function');

    try {
      final String jobId = const Uuid().v1();
      Map<String, dynamic> orderMap = {
        'orderId': acceptedOrder.id,
        'customerId': acceptedOrder.customerId,
        'isAccepted': true,
        'emergencyLevel': acceptedOrder.emergencyLevel,
        'reason': acceptedOrder.reason,
        'pickUpLat': acceptedOrder.pickUpLat,
        'pickUpLong': acceptedOrder.pickUpLong,
        'hospitalName': acceptedOrder.hospitalName,
        'dropOffLat': acceptedOrder.dropOffLat,
        'dropoffLong': acceptedOrder.dropoffLong,
        'job': {
          'id': jobId,
          'driverId': driverId,
          'onPickupLocation': false,
          'onTripToDropoff': false,
          'onDropoffLocation': false,
          'isDelivered': false
        }
      };

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(acceptedOrder.id)
          .set(orderMap)
          .catchError((e) {
        print(e);
      });

      final Emergency order = Emergency.fromJson(orderMap);

      return order;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Emergency> updateJob({
    required Emergency acceptedOrder,
    required bool onPickupLocation,
    required bool onTripToDropoff,
    required bool onDropoffLocation,
    required bool isDelivered,
  }) async {
    print('OrderFirestoreService: updateJob Function');

    try {
      Map<String, dynamic> orderMap = {
        'orderId': acceptedOrder.id,
        'customerId': acceptedOrder.customerId,
        'isAccepted': acceptedOrder.isAccepted,
        'emergencyLevel': acceptedOrder.emergencyLevel,
        'reason': acceptedOrder.reason,
        'pickUpLat': acceptedOrder.pickUpLat,
        'pickUpLong': acceptedOrder.pickUpLong,
        'hospitalName': acceptedOrder.hospitalName,
        'dropOffLat': acceptedOrder.dropOffLat,
        'dropoffLong': acceptedOrder.dropoffLong,
        'job': {
          'id': acceptedOrder.job!.id,
          'driverId': acceptedOrder.job!.driverId,
          'onPickupLocation': onPickupLocation,
          'onTripToDropoff': onTripToDropoff,
          'onDropoffLocation': onDropoffLocation,
          'isDelivered': isDelivered
        }
      };

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(acceptedOrder.id)
          .set(orderMap)
          .catchError((e) {
        print(e);
      });

      final Emergency order = Emergency.fromJson(orderMap);

      return order;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Emergency> getOrderById({
    required String orderId,
  }) async {
    print('OrderFirestoreService: getOrderById Function');

    try {
      bool orderFound = false;
      late Emergency order;
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where('orderId', isEqualTo: orderId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (final doc in querySnapshot.docs) {
          orderFound = true;
          Map<String, dynamic> orderMap = {
            'orderId': doc['orderId'],
            'customerId': doc['customerId'],
            'isAccepted': doc['isAccepted'],
            'emergencyLevel': doc['emergencyLevel'],
            'reason': doc['reason'],
            'pickUpLat': doc['pickUpLat'],
            'pickUpLong': doc['pickUpLong'],
            'hospitalName': doc['hospitalName'],
            'dropOffLat': doc['dropOffLat'],
            'dropoffLong': doc['dropoffLong'],
          };
          if (doc['isAccepted'] == true) {
            orderMap.addAll({
              'job': {
                'id': doc['job']['id'],
                'driverId': doc['job']['driverId'],
                'onPickupLocation': doc['job']['onPickupLocation'],
                'onTripToDropoff': doc['job']['onTripToDropoff'],
                'onDropoffLocation': doc['job']['onDropoffLocation'],
                'isDelivered': doc['job']['isDelivered'],
              }
            });
          }
          order = Emergency.fromJson(orderMap);
        }
      });
      if (orderFound) {
        return order;
      } else {
        throw 'Order not found';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
