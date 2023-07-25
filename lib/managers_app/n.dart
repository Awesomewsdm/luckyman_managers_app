// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luckyman_managers_app/Model/text_style.dart';
// import 'package:luckyman_managers_app/managers_app/bottom_button_widget.dart';
// import 'package:luckyman_managers_app/managers_app/bus_card_widget.dart';
// import 'package:luckyman_managers_app/managers_app/bus_model.dart';
// import 'package:luckyman_managers_app/managers_app/controllers.dart';

// class AllBuses extends StatelessWidget {
//   AllBuses({super.key});

//   final List<String> busClass = ["ECONOMY", "EXECUTIVE"];
//   final List<String> busType = ["VIP", "STC"];
//   final List<int> noOfSeats = [
//     28,
//     29,
//     30,
//     31,
//     32,
//     33,
//     34,
//     35,
//     36,
//     37,
//     39,
//     40,
//     41,
//     42,
//     43,
//     44,
//     45
//   ];

//   final BusController busController = Get.put(BusController());
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Buses"),
//       ),
//       body: StreamBuilder(
//           stream: busController.getBusFromDB(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasData) {
//                 return BusCardWidget(
//                   size: size,
//                   busNo: snapshot.data["busNo"],
//                   origin: snapshot.data["origin"],
//                   destination: snapshot.data["destination"],
//                   busClass: snapshot.data["busClass"],
//                   busType: snapshot.data["buType"],
//                   pickupPoint: snapshot.data["pickupPoint"],
//                   ticketPrice: snapshot.data["ticketPrice"],
//                   departureTime: snapshot.data["departureTime"],
//                   departureDate: snapshot.data["departureDate"],
//                   onTap: () {},
//                 );
//               } else {
//                 return const Center(
//                   child: Text("No buses available"),
//                 );
//               }
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             Get.bottomSheet(
//                 SingleChildScrollView(
//                   child: Container(
//                     height: size.height * 0.7,
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: FutureBuilder(
//                           future: busController
//                               .getBookingDataFromDB("booking-menu-items"),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.done) {
//                               if (snapshot.hasData) {
//                                 return Form(
//                                   key: _formKey,
//                                   child: Column(
//                                     children: [
//                                       const BlackTextWidget(
//                                           fontSize: 20, text: "ADD BUS"),
//                                       const Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 120),
//                                         child: Divider(
//                                           thickness: 5,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController
//                                                     .destination.value = value!;
//                                               },
//                                               items: snapshot
//                                                   .data!["Destinations"],
//                                               formLabel: "Destination",
//                                               dropdownTitle:
//                                                   'Select Destination',
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.origin.value =
//                                                     value!;
//                                               },
//                                               items: snapshot.data!["Origin"],
//                                               formLabel: "Origin",
//                                               dropdownTitle: 'Select Origin',
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.depatureDate
//                                                     .value = value!;
//                                               },
//                                               items: snapshot
//                                                   .data!["Departure Dates"],
//                                               formLabel: "Departure Date",
//                                               dropdownTitle: 'Select Date',
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.depatureDate
//                                                     .value = value!;
//                                               },
//                                               items: snapshot
//                                                   .data!["Departure Times"],
//                                               formLabel: "Departure Time",
//                                               dropdownTitle: 'Select Time',
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       DropdownMenuWidget(
//                                         validator: (value) {
//                                           if (value == null) {
//                                             return 'Please select one option';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         onChanged: (value) {
//                                           busController.depatureDate.value =
//                                               value!;
//                                         },
//                                         items: snapshot.data!["Pickup Points"],
//                                         formLabel: "Pickup Point",
//                                         dropdownTitle: 'Select Pickup Point',
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.depatureDate
//                                                     .value = value!;
//                                               },
//                                               items: busClass,
//                                               formLabel: "Bus Class",
//                                               dropdownTitle: 'Select class',
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.depatureDate
//                                                     .value = value!;
//                                               },
//                                               items: busType,
//                                               formLabel: "Bus Type",
//                                               dropdownTitle: 'Select type',
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.noOfSeats.value =
//                                                     value! as int;
//                                               },
//                                               items: noOfSeats,
//                                               formLabel: "No of Seats",
//                                               dropdownTitle:
//                                                   'Select no of seats',
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: DropdownMenuWidget(
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return 'Please select one option';
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               onChanged: (value) {
//                                                 busController.agents.value =
//                                                     value!;
//                                               },
//                                               items: snapshot.data!["Agents"],
//                                               formLabel: "Agents",
//                                               dropdownTitle: 'Assign agents',
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Text("Ticket price"),
//                                                 TextFormField(
//                                                   controller:
//                                                       busController.ticketPrice,
//                                                   validator: (value) {
//                                                     if (value!.isEmpty) {
//                                                       return "Please enter a valid price";
//                                                     } else {
//                                                       return null;
//                                                     }
//                                                   },
//                                                   // controller: loginController.password,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     contentPadding:
//                                                         EdgeInsets.all(8.0),
//                                                     prefixIcon:
//                                                         Icon(Icons.money),
//                                                     labelText:
//                                                         "Enter price here",
//                                                     hintText: "Eg; 100.00",
//                                                     border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(10.0),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Text("Bus Number"),
//                                                 TextFormField(
//                                                   validator: (value) {
//                                                     if (value!.isEmpty) {
//                                                       return "Please enter a valid bus number";
//                                                     } else {
//                                                       return null;
//                                                     }
//                                                   },
//                                                   controller:
//                                                       busController.busNo,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     contentPadding:
//                                                         EdgeInsets.all(8.0),
//                                                     prefixIcon:
//                                                         Icon(Icons.bus_alert),
//                                                     labelText:
//                                                         "Enter bus number here",
//                                                     hintText: "Eg; GH-0123-14",
//                                                     border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                         Radius.circular(10.0),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const Spacer(),
//                                       BottomButton(
//                                         height: 40,
//                                         onPressed: () async {
//                                           var busModel = BusModel(
//                                             destination:
//                                                 busController.destination.value,
//                                             origin: busController.origin.value,
//                                             depatureDate: busController
//                                                 .depatureDate.value,
//                                             depatureTime: busController
//                                                 .depatureTime.value,
//                                             pickupPoint:
//                                                 busController.pickupPoint.value,
//                                             buType: busController.busType.value,
//                                             busClass:
//                                                 busController.busClass.value,
//                                             noOfSeats:
//                                                 busController.noOfSeats.value,
//                                             ticketPrice: busController
//                                                 .ticketPrice
//                                                 .toString(),
//                                             bookedSeats:
//                                                 busController.bookedSeats,
//                                             busNo:
//                                                 busController.busNo.toString(),
//                                             agents: busController.agents.value,
//                                             agentsNo:
//                                                 busController.agentsNo.value,
//                                           );

//                                           await busController.addBusToDB(
//                                               busModel,
//                                               busController.busNo.text);

//                                           Get.back();
//                                         },
//                                         bottomTextLabel: "SAVE",
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               } else if (snapshot.hasError) {
//                                 return Center(
//                                   child: Text(
//                                     snapshot.error.toString(),
//                                   ),
//                                 );
//                               } else {
//                                 return const Text("Something went wrong");
//                               }
//                             } else {
//                               return Expanded(
//                                 child: SizedBox(
//                                   height: size.height,
//                                   child: const Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 ),
//                               );
//                             }
//                           }),
//                     ),
//                   ),
//                 ),
//                 isScrollControlled: true);
//           }),
//     );
//   }
// }
