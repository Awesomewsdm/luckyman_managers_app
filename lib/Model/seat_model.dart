import 'package:get/get.dart';
import 'package:luckyman_managers_app/Controllers/booking_controller.dart';
import 'package:luckyman_managers_app/Controllers/seat_selection_controller.dart';
import 'package:luckyman_managers_app/constants/colors.dart';

import 'package:flutter/material.dart';

class SeatLayoutModel {
  final int rows;
  final int cols;
  List<Map<String, dynamic>> seatTypes;
  final int gap;
  final int gapColIndex;
  final bool isLastFilled;
  final List<int> rowBreaks;
  SeatLayoutModel({
    required this.rows,
    required this.cols,
    required this.seatTypes,
    required this.gap,
    required this.gapColIndex,
    required this.isLastFilled,
    required this.rowBreaks,
  });
}

final executiveseatLayout = SeatLayoutModel(
  rows: 10,
  cols: 4,
  gap: 2,
  gapColIndex: 2,
  isLastFilled: true,
  rowBreaks: [10],
  seatTypes: [],
);

final economyseatLayout = SeatLayoutModel(
  rows: 12,
  cols: 5,
  gap: 2,
  gapColIndex: 2,
  isLastFilled: true,
  rowBreaks: [11],
  seatTypes: [],
);

var kBackgroundBoxDecoration = const BoxDecoration(
  boxShadow: [
    BoxShadow(
        blurStyle: BlurStyle.outer,
        offset: Offset(0, 3),
        blurRadius: 2.0,
        spreadRadius: 5.0,
        color: Colors.black),
  ],
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(15.0),
  ),
);

var kHomeBackgroundBoxDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20),
  ],
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);

double seatSize = 35.0;

// BoxShadow primaryBoxShadow = const
var kHomeWidgetsBoxDecoration = BoxDecoration(
    border: Border.all(color: Colors.lightBlue),
    color: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 7),
    ]);

var kPrimaryBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20),
    ]);

class SeatLayoutBuilder extends StatelessWidget {
  SeatLayoutBuilder({
    super.key,
    required this.model,
    required this.seatSelectionController,
    required this.destination,
    required this.selectedSeatList,
    required this.busClass,
    required this.amount,
    required this.ticketPrice,
    required this.bookedSeatsFromDB,
  });

  final SeatLayoutModel? model;
  final SeatSelectionController seatSelectionController;
  final String destination;
  final String busClass;
  final RxList<dynamic> selectedSeatList;
  final RxDouble amount;
  final double ticketPrice;
  final List<dynamic> bookedSeatsFromDB;

  final BusBookingController busBookingController =
      Get.put(BusBookingController());

  @override
  Widget build(BuildContext context) {
    int seatCounter = 0;
    RxDouble unitSeatPrice = amount;
    double seatSize = 35.0;

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: 1,
      itemBuilder: ((context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  "Bus Type: ${destination.capitalizeFirst} - ${busClass.capitalizeFirst}"),
            ),
            const Divider(
              color: tLightBlue,
            ),
            ...List.generate(model!.rowBreaks[index], (row) {
              return Wrap(
                children: List.generate(model!.cols, (col) {
                  // Adding columns breaks
                  // Adding last seats
                  if ((col == model!.gapColIndex) &&
                      (row != model!.rowBreaks[index] - 1 &&
                          model!.isLastFilled)) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: seatSize,
                        width: seatSize,
                        alignment: Alignment.center,
                      ),
                    );
                  }

                  // numbering the seats
                  seatCounter++;
                  String seatNo = '$seatCounter';

                  var isBooked = bookedSeatsFromDB.contains(seatNo);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: GestureDetector(
                        onTap: isBooked
                            ? null
                            : () {
                                seatSelectionController.isSeatSelected.value =
                                    true;

                                // var dbPriceDocRef = await BusSeatsPrices()
                                //     .getSeatPrices(
                                //         '$busClass-bus-seats-prices');

                                // final price = dbPriceDocRef![destination];

                                if (selectedSeatList.contains(seatNo)) {
                                  unitSeatPrice.value =
                                      unitSeatPrice.value - ticketPrice;

                                  selectedSeatList.remove(seatNo);

                                  if (selectedSeatList.isEmpty) {
                                    seatSelectionController
                                        .isSeatSelected.value = false;
                                  }
                                } else {
                                  unitSeatPrice.value =
                                      unitSeatPrice.value + ticketPrice;

                                  if (selectedSeatList.length >
                                      SeatSelectionController
                                          .instance.noOfSeats) {
                                    unitSeatPrice.value =
                                        unitSeatPrice.value - ticketPrice;

                                    selectedSeatList.removeAt(4);

                                    selectedSeatList.add(seatNo);
                                  } else {
                                    selectedSeatList.add(seatNo);
                                  }
                                }
                                busBookingController.selectedSeats.value =
                                    selectedSeatList;
                              },
                        child: Obx(
                          () => Container(
                            height: seatSize,
                            width: seatSize,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedSeatList.contains(seatNo)
                                    ? emptySeatColor
                                    : selectedSeatColor,
                              ),
                              color: isBooked
                                  ? bookedSeatColor
                                  : selectedSeatList.contains(seatNo)
                                      ? selectedSeatColor
                                      : emptySeatColor,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                seatNo,
                                style: TextStyle(
                                  color: isBooked
                                      ? activeSeatNumberColor
                                      : selectedSeatList.contains(seatNo)
                                          ? activeSeatNumberColor
                                          : inactiveSeatNumberColor,
                                ),
                              ),
                            ),
                          ),
                        )),
                  );
                }),
              );
            }),
          ],
        );
      }),
    );
  }
}
