import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Model/text_style.dart';
import 'package:luckyman_managers_app/Screens/home_screen.dart';
import 'package:luckyman_managers_app/managers_app/add_general_bus_details.dart';
import 'package:luckyman_managers_app/managers_app/all_buses_screen.dart';
import 'package:luckyman_managers_app/managers_app/styles.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 30.0,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30.0, top: 30),
          child: Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.amber,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height,
            decoration: kHomeBackgroundBoxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AshTextWidget(
                  text: 'Welcome',
                  fontSize: 18,
                ),
                const BlackTextWidget(
                  text: "Admin",
                  fontSize: 25,
                  color: Colors.lightBlue,
                ),
                // const UserProfileImage(
                //   width: 60,
                //   height: 60,
                // ),
                const Divider(
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 10,
                ),
                const BlackTextWidget(
                  text: 'What would you like to do?',
                  fontSize: 24,
                ),
                const SizedBox(
                  height: 20,
                ),
                HomeCardWidget(
                  onTap: () {
                    Get.to(() => const AllAvailableBuses());
                  },
                  size: size,
                  label: "View And Add New Buses",
                ),
                const SizedBox(
                  height: 20,
                ),
                HomeCardWidget(
                  onTap: () {
                    Get.to(() => const FilterPage());
                  },
                  size: size,
                  label: "General Bookings",
                ),
                const SizedBox(
                  height: 20,
                ),
                HomeCardWidget(
                  onTap: () {
                    Get.to(() => const AddDetailsScreen());
                  },
                  size: size,
                  label: "Update General Booking",
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    super.key,
    required this.size,
    required this.label,
    required this.onTap,
  });

  final Size size;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 80,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(color: Colors.lightBlue),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlackTextWidget(
                text: label,
                fontSize: 24,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward,
                color: Colors.lightBlue,
              )
            ],
          ),
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
