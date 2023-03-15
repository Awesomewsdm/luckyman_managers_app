import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusBookingController extends GetxController {
  static BusBookingController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  final selectedDestination = ''.obs;
  final selectedBusType = ''.obs;
  final selectedInstitution = ''.obs;
  final selectedDepatureTime = ''.obs;
  final selectedDepatureDate = ''.obs;
  final selectedPickupPoint = ''.obs;
  final selectedSchool = ''.obs;
  final selectedBusClass = "".obs;

  final agentName = TextEditingController();

  Future<void> addSeatListToDB(
      List<dynamic> seatList, String destination, String docRef) async {
    await _db
        .collection("Booking Data")
        .doc(docRef)
        .update({
          destination: FieldValue.arrayUnion(seatList),
        })
        .whenComplete(
          () => Get.snackbar(
            "Success",
            'Seat Added',
            snackPosition: SnackPosition.BOTTOM,
            colorText: const Color.fromARGB(255, 15, 32, 46),
            backgroundColor: Colors.blue.withOpacity(0.7),
          ),
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error, stackTrace) {
          Get.snackbar(
            "Error",
            'Sorry, something went wrong',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.blue.withOpacity(0.7),
          );
        });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBookingMenuItems(
      String docID) async {
    return await FirebaseFirestore.instance
        .collection("Booking Data")
        .doc(docID)
        .get();
  }
}
