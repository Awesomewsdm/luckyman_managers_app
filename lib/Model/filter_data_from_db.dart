// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class FilterDataFromDB {
  final String? selectedDestination;
  final String? selectedBusClass;
  final String? selectedBusType;
  final String? selectedDepartureTime;
  final String? selectedDepartureDate;
  final String? selectedOrigin;

  final String? selectedPickupPoint;
  // final String selectedSeatNo;
  FilterDataFromDB({
    this.selectedOrigin,
    this.selectedDestination,
    this.selectedBusClass,
    this.selectedBusType,
    this.selectedDepartureTime,
    this.selectedDepartureDate,
    this.selectedPickupPoint,
    // this.selectedSeatNo,
  });

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

  Stream<QuerySnapshot> getSimplidiedFilterDataFromDB() {
    var db = FirebaseFirestore.instance;

    var qSnap = db
        .collectionGroup("Booking Info")
        .where("selectedDepatureDate", isEqualTo: selectedDepartureDate)
        .where("selectedSeatNo", isNotEqualTo: null)
        .where("selectedOrigin", isEqualTo: selectedOrigin)
        .where("selectedDestination", isEqualTo: selectedDestination)
        .orderBy("userName")
        .snapshots();

    return qSnap;
  }
}
        // .where("isUserBookingComplete", isEqualTo: true)
