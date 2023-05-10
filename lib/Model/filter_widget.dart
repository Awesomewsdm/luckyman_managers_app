import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Controllers/booking_controller.dart';
import '../Screens/homescreen2.dart';
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

  final List<String> busClass = [
    'ECONOMY',
    'EXECUTIVE',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: FutureBuilder(
          future:
              busBookingController.getBookingMenuItems("booking-menu-items"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BookingDropdownMenu(
                          onChanged: (value) {
                            busBookingController.selectedSchool.value = value!;
                          },
                          items: snapshot.data!["Tertiary Schools"],
                          formLabel: 'Select institution',
                          dropdownTitle: 'Institution',
                        ),
                        BookingDropdownMenu(
                          items: snapshot.data!["Destinations"],
                          formLabel: 'Select destination',
                          onChanged: (value) {
                            busBookingController.selectedDestination.value =
                                value!;
                          },
                          dropdownTitle: 'Destination',
                        ),
                        BookingDropdownMenu(
                          onChanged: (value) {
                            busBookingController.selectedBusType.value = value!;
                          },
                          items: busType,
                          formLabel: 'Select Bus Type',
                          dropdownTitle: 'Bus Type',
                        ),
                        BookingDropdownMenu(
                          onChanged: (value) {
                            busBookingController.selectedBusClass.value =
                                value!;
                          },
                          items: busClass,
                          formLabel: 'Select Bus Class',
                          dropdownTitle: 'Bus Class',
                        ),
                        BookingDropdownMenu(
                          onChanged: (value) {
                            busBookingController.selectedDepatureDate.value =
                                value!;
                          },
                          items: snapshot.data!["Departure Dates"],
                          formLabel: 'Select Depature Date',
                          dropdownTitle: 'Depature Date',
                        ),
                        BookingDropdownMenu(
                          onChanged: (value) {
                            busBookingController.selectedDepatureTime.value =
                                value!;
                          },
                          items: snapshot.data!["Departure Times"],
                          formLabel: 'Select Depature Time',
                          dropdownTitle: 'Depature Time',
                        ),
                        BookingDropdownMenu(
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
                          width: size.width,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Get.to(() => const BookingDataScreen());
                              }
                            },
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
                                      fontSize: 25, color: Colors.white);
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
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          }),
    );
  }
}
