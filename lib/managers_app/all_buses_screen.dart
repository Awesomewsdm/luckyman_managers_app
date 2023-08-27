import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Model/bus_info_card.dart';
import 'package:luckyman_managers_app/Model/text_style.dart';
import 'package:luckyman_managers_app/managers_app/bottom_button_widget.dart';
import 'package:luckyman_managers_app/managers_app/bus_bookings_screen.dart';
import 'package:luckyman_managers_app/managers_app/bus_card_widget.dart';
import 'package:luckyman_managers_app/managers_app/bus_model.dart';
import 'package:luckyman_managers_app/managers_app/controllers.dart';

class AllAvailableBuses extends StatefulWidget {
  const AllAvailableBuses({
    super.key,
  });

  @override
  State<AllAvailableBuses> createState() => _AllAvailableBusesState();
}

class _AllAvailableBusesState extends State<AllAvailableBuses> {
  final RxBool _isBottomSheetOpen = false.obs;

  void _openBottomSheet() {
    _isBottomSheetOpen.value = true;
    Get.bottomSheet(
      const BottomSheetWidget(),
      isDismissible: false,
    );
  }

  void _closeBottomSheet() {
    _isBottomSheetOpen.value = false;
    Get.back();
  }

  final BusController busController = Get.put(BusController());
  final TextEditingController _searchController = TextEditingController();
  final CollectionReference _busesCollection =
      FirebaseFirestore.instance.collection("Buses");

  List<DocumentSnapshot> busSnapshot = [];
  bool _isLoading = false;
  String searchDestination = '';
  String searchOrigin = '';

  Future<void> _getBuses() async {
    setState(() {
      _isLoading = true;
    });

    QuerySnapshot snapshot;

    if (searchDestination.isNotEmpty && searchOrigin.isNotEmpty) {
      snapshot = await _busesCollection
          .where('destination', isEqualTo: searchDestination)
          .where('origin', isEqualTo: searchOrigin)
          .get();
    } else if (searchDestination.isNotEmpty) {
      snapshot = await _busesCollection
          .where('destination', isEqualTo: searchDestination)
          .get();
    } else if (searchOrigin.isNotEmpty) {
      snapshot =
          await _busesCollection.where('origin', isEqualTo: searchOrigin).get();
    } else {
      snapshot = await _busesCollection.get();
    }

    setState(() {
      busSnapshot = snapshot.docs;
      _isLoading = false;
    });
  }

  Future<void> _refreshBuses() async {
    await _getBuses();
  }

  @override
  void initState() {
    super.initState();
    _getBuses();
  }

  final busClass = ["ECONOMY", "EXECUTIVE"];
  final busType = ["VIP", "STC"];
  final noOfSeats = [31, 45];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Available Buses"),
      ),
      body: RefreshIndicator(
          onRefresh: _refreshBuses,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchDestination = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search by Destination or Origin",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Text("No of buses: ${busSnapshot.length}"),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : busSnapshot.isEmpty
                        ? const Center(child: Text("No buses available"))
                        : ListView.builder(
                            itemCount: busSnapshot.length,
                            itemBuilder: (context, index) {
                              final buses = busSnapshot[index];

                              final Map<String, dynamic> bus =
                                  buses.data() as Map<String, dynamic>;

                              final List<dynamic> bookedSeats =
                                  busSnapshot[index]["bookedSeats"];

                              final noOfSeats = bus["noOfSeats"];

                              final remainingSeats =
                                  noOfSeats - bookedSeats.length;

                              var ticketPriceFromDB = bus["ticketPrice"];

                              var ticketPrice = ticketPriceFromDB.toDouble();

                              busController.pickupPoint.value =
                                  bus["pickupPoint"];
                              busController.busType.value = bus["busType"];
                              busController.departureTime.value =
                                  bus["departureTime"];
                              busController.busClass.value = bus["busClass"];
                              busController.busSeatsList.value =
                                  bus['bookedSeats'] as List<dynamic>;
                              busController.reference.value =
                                  buses.reference.id;
                              return BusInfoCard(
                                onEdit: () => Get.to(() => BusBookingsScreen(
                                    busId: buses.reference.id)),
                                onDelete: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Confirm Delete'),
                                      content: const Text(
                                          'Are you sure you want to delete this bus?'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            busController
                                                .deleteBus(buses.reference.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                // onEdit: ,
                                busNo: bus["busNo"] ?? "",
                                ticketPrice: ticketPrice.toString(),
                                departureDate: bus["departureDate"] ?? "",
                                departureTime: bus["departureTime"] ?? "",
                                busType: bus["busType"] ?? "",
                                origin: bus["origin"] ?? "",
                                destination: bus["destination"] ?? "",
                                pickupPoint: bus["pickupPoint"] ?? "",
                                remainingSeats: remainingSeats,
                                bookedSeats: '${bookedSeats.length}',
                                index: "${index + 1}",
                              );
                            },
                          ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.bottomSheet(
                StatefulBuilder(
                  builder: (context, setState) => SingleChildScrollView(
                    child: Container(
                      height: size.height * 0.9,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                            future: busController
                                .getBookingDataFromDB("booking-menu-items"),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Form(
                                    // key: _formKey,
                                    child: Column(
                                      children: [
                                        const BlackTextWidget(
                                            fontSize: 20, text: "ADD BUS"),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 120),
                                          child: Divider(
                                            thickness: 5,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownMenuWidget(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select one option';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  busController.destination
                                                      .value = value!;
                                                },
                                                items: snapshot
                                                    .data!["Destinations"],
                                                formLabel: "Destination",
                                                dropdownTitle:
                                                    'Select Destination',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: DropdownMenuWidget(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select one option';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  busController.origin.value =
                                                      value!;
                                                },
                                                items: snapshot.data!["Origin"],
                                                formLabel: "Origin",
                                                dropdownTitle: 'Select Origin',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownMenuWidget(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select one option';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  busController.departureDate
                                                      .value = value!;
                                                },
                                                items: snapshot
                                                    .data!["Departure Dates"],
                                                formLabel: "Departure Date",
                                                dropdownTitle: 'Select Date',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: DropdownMenuWidget(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select one option';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  busController.departureTime
                                                      .value = value!;
                                                },
                                                items: snapshot
                                                    .data!["Departure Times"],
                                                formLabel: "Departure Time",
                                                dropdownTitle: 'Select Time',
                                              ),
                                            ),
                                          ],
                                        ),
                                        DropdownMenuWidget(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select one option';
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChanged: (value) {
                                            busController.pickupPoint.value =
                                                value!;
                                          },
                                          items:
                                              snapshot.data!["Pickup Points"],
                                          formLabel: "Pickup Point",
                                          dropdownTitle: 'Select Pickup Point',
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: DropdownMenuWidget(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select one option';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  busController.busClass.value =
                                                      value!;
                                                },
                                                items: busClass,
                                                formLabel: "Bus Class",
                                                dropdownTitle: 'Select class',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: DropdownMenuWidget(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select one option';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  busController.busType.value =
                                                      value!;
                                                },
                                                items: busType,
                                                formLabel: "Bus Type",
                                                dropdownTitle: 'Select type',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: DropdownMenuWidget(
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select one option';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onChanged: (value) {
                                              busController.agents.value =
                                                  value!;
                                            },
                                            items: snapshot.data!["Agents"],
                                            formLabel: "Agents",
                                            dropdownTitle: 'Assign agents',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Ticket price"),
                                                  TextFormField(
                                                    controller: busController
                                                        .ticketPrice,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please enter a valid price";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    // controller: loginController.password,
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(8.0),
                                                      prefixIcon:
                                                          Icon(Icons.money),
                                                      labelText:
                                                          "Enter price here",
                                                      hintText: "Eg; 100.00",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Bus Number"),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Please enter a valid bus number";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller:
                                                        busController.busNo,
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(8.0),
                                                      prefixIcon:
                                                          Icon(Icons.bus_alert),
                                                      labelText:
                                                          "Enter bus number here",
                                                      hintText:
                                                          "Eg; GH-0123-14",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        BottomButton(
                                          height: 40,
                                          onPressed: () async {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            var busModel = BusModel(
                                              destination: busController
                                                  .destination.value,
                                              origin:
                                                  busController.origin.value,
                                              departureDate: busController
                                                  .departureDate.value,
                                              departureTime: busController
                                                  .departureTime.value,
                                              pickupPoint: busController
                                                  .pickupPoint.value,
                                              busType:
                                                  busController.busType.value,
                                              busClass:
                                                  busController.busClass.value,
                                              noOfSeats: busController
                                                          .busClass.value ==
                                                      "ECONOMY"
                                                  ? 45
                                                  : 31,
                                              ticketPrice: int.parse(
                                                  busController
                                                      .ticketPrice.text),
                                              bookedSeats:
                                                  busController.bookedSeats,
                                              busNo: busController.busNo.text,
                                              agents:
                                                  busController.agents.value,
                                              agentsNo:
                                                  busController.agentsNo.value,
                                            );

                                            await busController.addBusToDB(
                                                busModel,
                                                busController.busNo.text);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Get.back();
                                          },
                                          bottomTextLabel: "SAVE",
                                          isLoading: _isLoading,
                                        ),
                                      ],
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
                      ),
                    ),
                  ),
                ),
                isScrollControlled: true);
          }),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Bottom Sheet Content'),
          ElevatedButton(
            onPressed: () {
              Get.find<AllAvailableBuses>()._closeBottomSheet();
            },
            child: const Text('Close Bottom Sheet'),
          ),
        ],
      ),
    );
  }
}
