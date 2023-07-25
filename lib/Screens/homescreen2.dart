import 'dart:math';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:luckyman_managers_app/Controllers/booking_controller.dart';
import 'package:luckyman_managers_app/Model/dashboard_app_bar.dart';
import 'package:luckyman_managers_app/Model/filter_data_from_db.dart';
import 'package:luckyman_managers_app/Model/text_style.dart';
import 'package:luckyman_managers_app/components/expansiontile_widget.dart';

class BookingDataScreen extends StatefulWidget {
  const BookingDataScreen({super.key});

  @override
  State<BookingDataScreen> createState() => _BookingDataScreenState();
}

class _BookingDataScreenState extends State<BookingDataScreen> {
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  final _db = FirebaseFirestore.instance;

  // getselectedSeatNo() async {
  //   final snapshot =
  //       await _db.collection("Users").get().then((QuerySnapshot querySnapshot) {
  //     for (var doc in querySnapshot.docs) {
  //       FirebaseFirestore.instance.doc(doc.id).collection("Booking Info").get();
  //     }
  //   });

  final BusBookingController busBookingController =
      Get.put(BusBookingController());

  List<Map<String, dynamic>> users = [];
  @override
  void initState() {
    super.initState();
    // users =
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [const DashboardAppBar()];
            },
            body: TabBarView(
                children: tabs.map((Tab tab) {
              final String label = tab.text!;

              return StreamBuilder<QuerySnapshot>(
                  stream: FilterDataFromDB(
                          selectedOrigin:
                              busBookingController.selectedOrigin.value,
                          selectedDestination: label,
                          selectedDepartureDate:
                              busBookingController.selectedDepatureDate.value)
                      .getSimplidiedFilterDataFromDB(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text("Loading..."));
                    }
                    return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return ExpansionTile(
                                childrenPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                // tilePadding: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.blue.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(10.0)),
                                // tileColor: Colors.blue.withOpacity(0.1),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: const Icon(Icons.person_2_outlined),
                                ),
                                title: BlackTextWidget(
                                  text: data['userName'],
                                ),
                                subtitle: Text(data['selectedSeatNo'] == null
                                    ? "No seat booked yet"
                                    : "Seat No: ${data['selectedSeatNo']}"),
                                trailing: CircleAvatar(
                                  backgroundColor: _scanBarcode ==
                                          "Success: ${data['userName']}"
                                      ? Colors.green
                                      : Colors.red,
                                  child: _scanBarcode ==
                                          "Success: ${data['userName']}"
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.close),
                                ),
                                children: [
                                  TileChildrenWidget(
                                    firstTitle: 'Bus Class:',
                                    firstDescription:
                                        " ${data["selectedBusClass"]}",
                                    secondTitle: "Bus Type",
                                    secondDescription:
                                        "${data["selectedBusType"]}",
                                  ),
                                  const Divider(),
                                  TileChildrenWidget(
                                    firstTitle: 'Depature Date:',
                                    firstDescription:
                                        " ${data["selectedDepatureDate"]}",
                                    secondTitle: "Time:",
                                    secondDescription:
                                        " ${data["selectedDepatureTime"]}",
                                  ),
                                  const Divider(),
                                  TileChildrenWidget(
                                    firstTitle: "Amount Paid:",
                                    firstDescription: " GHC${data["price"]}",
                                    secondTitle: "Tel:",
                                    secondDescription:
                                        " ${data["phoneNumber"]}",
                                  ),
                                  const Divider(),
                                  TileChildrenWidget(
                                    firstTitle: "Pickup Point:",
                                    firstDescription:
                                        " ${data["selectedPickupPoint"]}",
                                  ),
                                ],
                              );
                            })
                            .toList()
                            .cast());
                  });
            }).toList()),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scanQR();
          },
          child: const Icon(
            Icons.qr_code_2_outlined,
            // color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}

const List<Tab> tabs = [
  Tab(
    text: 'Accra',
  ),
  Tab(
    text: 'Kasoa',
  ),
  Tab(
    text: 'Takoradi',
  ),
  Tab(
    text: 'Koforidua',
  ),
  Tab(
    text: 'Tema',
  ),
  Tab(
    text: 'Circle',
  ),
  Tab(
    text: 'Spintex-Sakumono',
  ),
  Tab(
    text: 'Tarkwa',
  ),
  Tab(
    text: 'Madina',
  ),
  Tab(
    text: 'Sunyani',
  ),
  Tab(
    text: 'Cape Coast',
  ),
];
