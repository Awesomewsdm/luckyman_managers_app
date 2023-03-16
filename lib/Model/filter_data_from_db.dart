import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FilterDataFromDB {
  final String selectedDestination;
  final String selectedBusClass;
  final String selectedBusType;
  final String selectedDepartureTime;
  final String selectedDepartureDate;
  final String selectedPickupPoint;

  FilterDataFromDB(
      this.selectedDestination,
      this.selectedBusClass,
      this.selectedBusType,
      this.selectedDepartureTime,
      this.selectedDepartureDate,
      this.selectedPickupPoint);

  Stream<QuerySnapshot> getDataFromDB() {
    Stream<QuerySnapshot> qSnap = FirebaseFirestore.instance
        .collectionGroup("Booking Info")
        .where("selectedDestination", isEqualTo: selectedDestination)
        .where("selectedBusClass", isEqualTo: selectedBusClass)
        .where("selectedBusType", isEqualTo: selectedBusType)
        .where("selectedDepatureTime", isEqualTo: selectedDepartureTime)
        .where("selectedDepatureDate", isEqualTo: selectedDepartureDate)
        .where("selectedPickupPoint", isEqualTo: selectedPickupPoint)
        .orderBy("userName")
        .snapshots();

    return qSnap;
  }
}
