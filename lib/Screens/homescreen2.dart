import 'dart:math';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:luckyman_managers_app/Controllers/booking_controller.dart';
import 'package:luckyman_managers_app/Model/filter_data_from_db.dart';

class MyCustomUI extends StatefulWidget {
  const MyCustomUI({super.key});

  @override
  State<MyCustomUI> createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<MyCustomUI> {
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int seatCounter = 0;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60.0, horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Amount",
                                textScaleFactor: 1.12,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                "GH¢8000",
                                textScaleFactor: 1.12,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Seat Booked",
                                textScaleFactor: 1.12,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black.withOpacity(.7),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                "30",
                                textScaleFactor: 1.12,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // snap: true,
                  pinned: true,
                  // floating: true,
                  expandedHeight: 200,
                  forceElevated: innerBoxIsScrolled,
                  elevation: 20,
                  shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
                  backgroundColor: Colors.white,
                  title: const Text(
                    'DASHBOARD',
                    textScaleFactor: 1.12,
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    IconButton(
                      color: Colors.lightBlue,
                      tooltip: "Search",
                      enableFeedback: true,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {},
                    ),
                    AppBarIcons(
                      icon: Icons.filter_list_rounded,
                      toolTip: "Filter",
                      onPressed: () {},
                    ),
                    AppBarIcons(
                      icon: Icons.more_vert_rounded,
                      toolTip: "More",
                      onPressed: () {},
                    ),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.black.withOpacity(.8),
                    unselectedLabelStyle:
                        TextStyle(color: Colors.black.withOpacity(.5)),
                    unselectedLabelColor: Colors.black.withOpacity(.4),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black.withOpacity(.8),
                    tabs: tabs,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                )
              ];
            },
            body: TabBarView(
                children: tabs.map((Tab tab) {
              final String label = tab.text!;

              return StreamBuilder<QuerySnapshot>(
                  stream: FilterDataFromDB(
                          label,
                          busBookingController.selectedBusClass.value,
                          busBookingController.selectedBusType.value,
                          busBookingController.selectedDepatureTime.value,
                          busBookingController.selectedDepatureDate.value,
                          busBookingController.selectedPickupPoint.value)
                      .getDataFromDB(),
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
                              return ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors.blue.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(10.0)),
                                tileColor: Colors.blue.withOpacity(0.1),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: const Icon(Icons.person_2_outlined),
                                ),
                                title: Text(data['userName']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(data['selectedSeatNo'] == null
                                        ? "No seat booked yet"
                                        : "Seat No: ${data['selectedSeatNo']}"),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(data["selectedBusClass"]),
                                  ],
                                ),
                                trailing: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
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

class AppBarIcons extends StatelessWidget {
  const AppBarIcons({
    super.key,
    required this.icon,
    required this.toolTip,
    required this.onPressed,
  });
  final IconData icon;
  final String toolTip;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.lightBlue,
      tooltip: toolTip,
      enableFeedback: true,
      icon: Icon(
        icon,
        color: Colors.lightBlue,
      ),
      onPressed: onPressed,
    );
  }
}

Widget cardWidget(
    BuildContext context, Widget route, String name, String image) {
  double w = MediaQuery.of(context).size.width;
  double f = MediaQuery.of(context).textScaleFactor;
  return InkWell(
    enableFeedback: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      HapticFeedback.lightImpact();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 30),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(w / 20, w / 20, w / 20, 0),
      height: w / 5,
      padding: EdgeInsets.all(w / 25),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: w / 2.0,
              // color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: f * 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(.8),
                    ),
                  ),
                  Text(
                    'Tap to know more',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: f * 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // height: _w / 5.5,
              width: w / 3.3,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                color: Colors.black.withOpacity(.2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.1), blurRadius: 30),
                ],
              ),
              child: const Center(
                child: Text(
                  'Add image here',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
];
