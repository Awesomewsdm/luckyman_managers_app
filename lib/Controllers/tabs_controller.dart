import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final _db = FirebaseFirestore.instance;

    getSeatPrices(String docID) async {
      final snapshot = await _db
          .collection("Bus Prices")
          .doc(docID)
          .get();

      final data = snapshot.data();

      return data;
      // ...
    }
}