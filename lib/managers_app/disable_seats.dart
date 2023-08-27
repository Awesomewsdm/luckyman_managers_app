import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Controllers/button_controller.dart';
import 'package:luckyman_managers_app/Controllers/seat_selection_controller.dart';
import 'package:luckyman_managers_app/Model/seat_model.dart';
import 'package:luckyman_managers_app/Model/text_style.dart';
import 'package:luckyman_managers_app/components/app_bar.dart';
import 'package:luckyman_managers_app/constants/alert.dart';
import 'package:luckyman_managers_app/constants/custom_icons_icons.dart';
import 'package:luckyman_managers_app/constants/sizes.dart';
import 'package:luckyman_managers_app/managers_app/bottom_button_widget.dart';
import '../constants/colors.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({
    Key? key,
    this.busSnapshot,
  }) : super(key: key);
  static String id = '/SeatSelectionScreen';

  // -- Controllers

  final DocumentSnapshot? busSnapshot;

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final SeatSelectionController seatSelectionController =
        Get.put(SeatSelectionController());

    final Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> bus =
        widget.busSnapshot!.data() as Map<String, dynamic>;

    var ticketPriceFromDB = bus["ticketPrice"];

    var ticketPrice = ticketPriceFromDB.toDouble();

    final bookedSeats = bus['bookedSeats'] as List<dynamic>;
    final destination = bus["destination"] as String;
    final busClass = bus["busClass"] as String;
    final noOfSeats = bus["noOfSeats"] as int;

    final ButtonController buttonController = Get.put(ButtonController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disable Seats"),
      ),
      backgroundColor: backgroundColor5,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SeatStatus(
                    boxColor: emptySeatColor,
                    iconLabel: 'Available',
                    border: Border.all(
                      color: selectedSeatColor,
                    ),
                  ),
                  SeatStatus(
                    iconLabel: 'Selected',
                    boxColor: selectedSeatColor,
                  ),
                  SeatStatus(
                    boxColor: bookedSeatColor,
                    iconLabel: 'Booked',
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: size.height,
                width: size.width - 50,
                decoration: kBackgroundBoxDecoration,
                child: SeatLayoutBuilder(
                  model:
                      noOfSeats == 45 ? economyseatLayout : executiveseatLayout,
                  seatSelectionController: seatSelectionController,
                  destination: destination,
                  selectedSeatList: seatSelectionController.userSelectedSeats,
                  amount: seatSelectionController.seatPrice,
                  busClass: busClass,
                  bookedSeatsFromDB: bookedSeats,
                  ticketPrice: ticketPrice,
                ),
              ),
            ]),
          ),
        ),
      ),
      bottomSheet: Container(
        height: size.height * 0.15,
        decoration: const BoxDecoration(
          color: tWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(CustomIcons.airlineSeatReclineExtra,
                              size: 25.0, color: tBlueColor),
                          SizedBox(
                            width: 6.0,
                          ),
                          AshTextWidget(text: 'Selected Seat'),
                        ],
                      ),
                      Obx(
                        () => Text(
                          seatSelectionController.userSelectedSeats.join(" , "),
                          style: TextStyle(
                            color: selectedSeatColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.money, size: 18.0, color: tBlueColor),
                          SizedBox(
                            width: 10.0,
                          ),
                          AshTextWidget(text: 'Total Price'),
                        ],
                      ),
                      Obx(
                        () => Text(
                          'GH¢${seatSelectionController.seatPrice.value}',
                          style: TextStyle(
                            color: selectedSeatColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: BottomButton(
                icon: const Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
                bottomTextLabel: 'DISABLE SEATS',
                loadingIcon: Obx(
                  () => SizedBox(
                    child: buttonController.isButtonClicked.value == true
                        ? const CircularProgressIndicator(color: tWhiteColor)
                        : const Text(""),
                  ),
                ),
                onPressed: () async {
                  if (seatSelectionController.isSeatSelected.value == true) {
                    buttonController.isButtonClicked.value = true;
                    await busBookingController.updateBookedSeatsList(
                      widget.busSnapshot!.id,
                      seatSelectionController.userSelectedSeats.toList(),
                      "Admin, ${seatSelectionController.userSelectedSeats}",
                    );
                    buttonController.isButtonClicked.value = false;
                  } else {
                    alert("Hey", "Select atleast one seat to continue!");
                  }
                },
                height: size.width * 0.15,
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   Get.delete<SeatSelectionController>();
  //   seatSelectionController.dispose();
  //   super.dispose();
  // }
}
