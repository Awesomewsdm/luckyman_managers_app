import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Controllers/booking_controller.dart';

import 'dropdown_widget.dart';

class FilterWidget extends StatelessWidget {
  FilterWidget({Key? key}) : super(key: key);
  final BusBookingController busBookingController =
      Get.put(BusBookingController());

  final _formKey = GlobalKey<FormState>();
  final List<String> busType = [
    'VIP',
    'STC',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: busBookingController.getBookingMenuItems("booking-menu-items"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: size.height * 0.8,
                      width: size.width * 0.85,
                      child: Column(
                        children: [
                          BookingDropdownMenu(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one option';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              busBookingController.selectedSchool.value =
                                  value!;
                            },
                            items: snapshot.data!["Tertiary Schools"],
                            formLabel: 'Select institution',
                            dropdownTitle: 'Institution',
                          ),
                          BookingDropdownMenu(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one option';
                              } else {
                                return null;
                              }
                            },
                            items: snapshot.data!["Destinations"],
                            formLabel: 'Select destination',
                            onChanged: (value) {
                              busBookingController.selectedDestination.value =
                                  value!;
                            },
                            dropdownTitle: 'Destination',
                          ),
                          BookingDropdownMenu(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one option';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              busBookingController.selectedBusType.value =
                                  value!;
                            },
                            items: busType,
                            formLabel: 'Select Bus Type',
                            dropdownTitle: 'Bus Type',
                          ),
                          BookingDropdownMenu(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one option';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              busBookingController.selectedDepatureDate.value =
                                  value!;
                            },
                            items: snapshot.data!["Departure Dates"],
                            formLabel: 'Select Depature Date',
                            dropdownTitle: 'Depature Date',
                          ),
                          BookingDropdownMenu(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one option';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              busBookingController.selectedDepatureTime.value =
                                  value!;
                            },
                            items: snapshot.data!["Departure Times"],
                            formLabel: 'Select Depature Time',
                            dropdownTitle: 'Depature Time',
                          ),
                          BookingDropdownMenu(
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one option';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              busBookingController.selectedPickupPoint.value =
                                  value!;
                            },
                            items: snapshot.data!["Pickup Points"],
                            formLabel: 'Select Pick Up Point',
                            dropdownTitle: 'Pickup Points',
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  // If the button is pressed, return green, otherwise blue
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.green;
                                  }
                                  return Colors.blue;
                                }),
                                textStyle:
                                    MaterialStateProperty.resolveWith((states) {
                                  // If the button is pressed, return size 40, otherwise 20
                                  if (states.contains(MaterialState.pressed)) {
                                    return const TextStyle(
                                        fontSize: 40, color: Colors.white);
                                  }
                                  return const TextStyle(
                                      fontSize: 20, color: Colors.white);
                                }),
                              ),
                              child: const Text(
                                "Proceed",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          } else {
            return Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
