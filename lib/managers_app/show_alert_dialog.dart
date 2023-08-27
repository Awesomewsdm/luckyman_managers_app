import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/managers_app/bus_bookings_screen.dart';
import 'package:luckyman_managers_app/managers_app/disable_seats.dart';

void showAlertDialog(size, String busId) {
  Get.bottomSheet(
      Container(
        color: Colors.amber,
        height: size.height * 0.75,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Get.to(
                    () => const SeatSelectionScreen(),
                  );
                },
                child: const Text("Disable bus seats"),
              ),
              TextButton(
                onPressed: () => Get.to(() => BusBookingsScreen(busId: busId)),
                child: const Text("View Passengers"),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}
