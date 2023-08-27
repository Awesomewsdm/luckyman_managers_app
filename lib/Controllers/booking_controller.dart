import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusBookingController extends GetxController {
  static BusBookingController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  final selectedDestination = ''.obs;
  final selectedOrigin = ''.obs;

  final selectedBusType = ''.obs;
  final selectedSeats = [].obs;
  final selectedInstitution = ''.obs;
  final selectedDepatureTime = ''.obs;
  final selectedDepatureDate = ''.obs;
  final selectedPickupPoint = ''.obs;
  final selectedSchool = ''.obs;
  final selectedBusClass = "".obs;
  final qrcodeResults = "".obs;

  final agentName = TextEditingController();

  final isDataFiltered = false.obs;

  Future<DocumentSnapshot<Map<String, dynamic>>> getBookingMenuItems(
      String docID) async {
    return await FirebaseFirestore.instance
        .collection("Booking Data")
        .doc(docID)
        .get();
  }

  Future<void> updateBookedSeatsList(String busDocRefID,
      List<dynamic> userSelectedSeats, String passengers) async {
    await _db
        .collection("Buses")
        .doc(busDocRefID)
        .update({
          'bookedSeats': FieldValue.arrayUnion(userSelectedSeats),
          "passengers": FieldValue.arrayUnion([passengers])
        })
        .whenComplete(
          () => Get.snackbar(
            "Success, Seats Added",
            '',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.blue[100],
            backgroundColor: Colors.blue.withOpacity(0.7),
          ),
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error, stackTrace) {
          Get.snackbar(
            "Error",
            'Sorry, something went wrong, seats not added',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.blue.withOpacity(0.7),
          );
        });
  }
}
