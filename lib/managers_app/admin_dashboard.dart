import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Screens/home_screen.dart';
import 'package:luckyman_managers_app/managers_app/add_general_bus_details.dart';
import 'package:luckyman_managers_app/managers_app/all_buses_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.navigation),
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hello, Admin",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            const Text("Welocome back!"),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  HomeCardWidget(
                    onTap: () {
                      Get.to(
                        () => const AllAvailableBuses(),
                      );
                    },
                    size: size,
                    label: "View And Add New Buses",
                    number: "42",
                  ),
                  HomeCardWidget(
                    onTap: () {
                      Get.to(
                        () => const FilterPage(),
                      );
                    },
                    size: size,
                    label: "All Bookings",
                    number: "40",
                  ),
                  HomeCardWidget(
                    onTap: () {
                      Get.to(
                        () => const AddDetailsScreen(),
                      );
                    },
                    size: size,
                    label: "Update Booking Details",
                    number: "20",
                  ),
                  HomeCardWidget(
                    onTap: () {
                      // Get.to(
                      //   () => const AllAvailableBuses(),
                      // );
                    },
                    size: size,
                    label: "Total Earnings",
                    number: "35",
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     const Text(
            //       "All Buses",
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     const Spacer(),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const AllAvailableBuses(),
            //           ),
            //         );
            //       },
            //       child: const Text(
            //         "See all",
            //         style: TextStyle(color: Colors.green),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    super.key,
    required this.size,
    required this.label,
    required this.number,
    required this.onTap,
  });

  final Size size;
  final String label;
  final String number;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 80,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(color: Colors.lightBlue),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  number,
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.bus_alert,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    this.width = 80.0,
    this.height = 80.0,
  }) : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20.0),
        image: const DecorationImage(
            image: AssetImage("assets/images/man-with-guiter.jpg"),
            fit: BoxFit.fill),
        border: Border.all(
          width: 5,
          color: Colors.white,
        ),
      ),
    );
  }
}
