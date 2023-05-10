// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:luckyman_managers_app/Model/dashboard_app_bar.dart';
// import 'package:luckyman_managers_app/Model/filter_data_from_db.dart';
// import 'package:luckyman_managers_app/Screens/homescreen2.dart';

// class SimplifiedBookingData extends StatefulWidget {
//   const SimplifiedBookingData({super.key});

//   @override
//   State<SimplifiedBookingData> createState() => _SimplifiedBookingDataState();
// }

// class _SimplifiedBookingDataState extends State<SimplifiedBookingData> {
//   String _scanBarcode = 'Unknown';

//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     final db = FirebaseFirestore.instance;
//     return DefaultTabController(
//       length: tabs.length,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: NestedScrollView(
//             floatHeaderSlivers: true,
//             headerSliverBuilder: (context, innerBoxIsScrolled) {
//               return [const DashboardAppBar()];
//             },
//             body: TabBarView(
//                 children: tabs.map((Tab tab) {
//               final String label = tab.text!;

//               return StreamBuilder<QuerySnapshot>(
//                   stream: FilterDataFromDB().getSimplidiedFilterDataFromDB(),
                         
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return const Center(child: Text('Something went wrong'),);
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: Text("Loading..."));
//                     }
//                     return ListView(
//                         children: snapshot.data!.docs
//                             .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//                               return ListTile(
//                                 contentPadding: const EdgeInsets.all(8.0),
//                                 shape: RoundedRectangleBorder(
//                                     side: BorderSide(
//                                         width: 3,
//                                         color: Colors.blue.withOpacity(0.1),),
//                                     borderRadius: BorderRadius.circular(10.0),),
//                                 tileColor: Colors.blue.withOpacity(0.1),
//                                 leading: CircleAvatar(
//                                   backgroundColor: Colors.primaries[Random()
//                                       .nextInt(Colors.primaries.length)],
//                                   child: const Icon(Icons.person_2_outlined),
//                                 ),
//                                 title: Text(data['userName']),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 7.0,
//                                     ),
//                                     Text(data['selectedSeatNo'] == null
//                                         ? "No seat booked yet"
//                                         : "Seat No: ${data['selectedSeatNo']}"),
//                                     const SizedBox(
//                                       height: 7.0,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(data["selectedBusClass"]),
//                                         const SizedBox(
//                                           width: 10.0,
//                                         ),
//                                         Text(data["selectedBusType"]),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 trailing: CircleAvatar(
//                                   backgroundColor: _scanBarcode ==
//                                           "Success: ${data['userName']}"
//                                       ? Colors.green
//                                       : Colors.red,
//                                   child: _scanBarcode ==
//                                           "Success: ${data['userName']}"
//                                       ? const Icon(Icons.check)
//                                       : const Icon(Icons.close),
//                                 ),
//                               );
//                             })
//                             .toList()
//                             .cast());
//                   });
//             }).toList()),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             scanQR();
//           },
//           child: const Icon(
//             Icons.qr_code_2_outlined,
//             // color: Colors.lightBlue,
//           ),
//         ),
//       ),
//     );
//   }
// }
