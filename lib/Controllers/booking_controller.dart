import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusBookingController extends GetxController {
  static BusBookingController get instance => Get.find();

  final selectedDestination = ''.obs;
  final selectedOrigin = ''.obs;

  final selectedBusType = ''.obs;
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
}
