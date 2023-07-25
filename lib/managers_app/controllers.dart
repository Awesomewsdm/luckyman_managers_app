import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bus_model.dart';

class BusController extends GetxController {
  static BusController get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final destination = ''.obs;
  final origin = ''.obs;
  final departureDate = ''.obs;
  final departureTime = ''.obs;
  final pickupPoint = ''.obs;
  final busType = ''.obs;
  final busSeatsList = [].obs;
  final reference = ''.obs;

  final busClass = ''.obs;
  final noOfSeats = 0.obs;
  final ticketPrice = TextEditingController();
  final bookedSeats = [].obs;
  final busNo = TextEditingController();

  final docID = ''.obs;
  final agents = ''.obs;
  final agentsNo = ''.obs;

  Future<DocumentSnapshot<Map<String, dynamic>>> getBookingDataFromDB(
      String docID) async {
    return await _db.collection("Booking Data").doc(docID).get();
  }

  Stream<dynamic> getBusFromDB() {
    return _db.collection("Buses").snapshots();
  }

  void deleteBus(String busId) async {
    try {
      await FirebaseFirestore.instance.collection("Buses").doc(busId).delete();
      // Show a success message using Get.snackbar
      Get.snackbar(
        'Success',
        'Bus deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Show an error message using Get.snackbar
      Get.snackbar(
        'Error',
        'An error occurred while deleting the bus.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addBusToDB(BusModel busModel, String docRef) async {
    await _db
        .collection("Buses")
        .doc(docRef)
        .set(busModel.toJson())
        .whenComplete(() {
      Get.snackbar(
        "Success",
        'Selected seats added',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.blue[100],
        backgroundColor: Colors.blue.withOpacity(0.7),
      );
    })
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
}
