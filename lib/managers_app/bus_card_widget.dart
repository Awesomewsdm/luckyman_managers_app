import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luckyman_managers_app/Model/text_style.dart';
import 'package:luckyman_managers_app/constants/colors.dart';
import 'package:luckyman_managers_app/managers_app/styles.dart';

class BusCardWidget extends StatelessWidget {
  const BusCardWidget({
    super.key,
    required this.size,
    required this.busNo,
    required this.origin,
    required this.destination,
    required this.busClass,
    required this.busType,
    required this.pickupPoint,
    required this.ticketPrice,
    required this.departureTime,
    required this.departureDate,
    required this.onTap,
  });

  final Size size;
  final String busNo;
  final String origin;
  final String destination;
  final String busClass;
  final String busType;
  final String pickupPoint;
  final int ticketPrice;
  final String departureTime;
  final String departureDate;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: kHomeWidgetsBoxDecoration,
        height: 170,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFe0f2f1),
                  ),
                  child: Image.asset(
                    "assets/images/Bus.png",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(busNo, style: kTextStyle),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("From"),
                            Text(origin, style: kTextStyle2),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("TO"),
                            Text(destination, style: kTextStyle2),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "¢$ticketPrice",
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 120.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: Colors.green),
                  ),
                  // decoration: kHomeWidgetsBoxDecoration,
                  child: Row(
                    children: [
                      Text(
                        busType,
                        style: GoogleFonts.poppins(),
                      ),
                      const VerticalDivider(
                        thickness: 4,
                      ),
                      Text(
                        busClass,
                      ),
                    ],
                  ),
                ),
                DateAndTextWidget(
                    textLabel: departureDate, icon: Icons.calendar_today),
                DateAndTextWidget(textLabel: departureTime, icon: Icons.alarm)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  DateAndTextWidget(textLabel: pickupPoint, icon: Icons.place),
                  const Spacer(),
                  GestureDetector(
                    onTap: onTap,
                    child: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateAndTextWidget extends StatelessWidget {
  const DateAndTextWidget({
    super.key,
    required this.textLabel,
    required this.icon,
  });

  final String textLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            textLabel,
            style: kTextStyle2,
          ),
        ),
      ],
    );
  }
}

class DropdownMenuWidget extends StatelessWidget {
  const DropdownMenuWidget({
    Key? key,
    required this.items,
    required this.formLabel,
    this.buttonWidth,
    this.formKey,
    this.onSaved,
    this.onChanged,
    this.validator,
    required this.dropdownTitle,
  }) : super(key: key);

  final List<dynamic> items;
  final String formLabel;
  final double? buttonWidth;
  final Key? formKey;
  final void Function(String?)? onSaved;
  final void Function(dynamic)? onChanged;
  final String? Function(String?)? validator;
  final String dropdownTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AshTextWidget(
            text: '$dropdownTitle :',
            fontWeight: FontWeight.w700,
          ),
          // Text(
          //   dropdownTitle,
          //   style:  TextStyle(fontWeight: FontWeight.w700,  color: Colors.lightBlue.shade50,),
          // ),
          const SizedBox(
            height: 5,
          ),
          DropdownButtonFormField2(
            key: formKey,
            buttonWidth: buttonWidth,
            buttonDecoration: BoxDecoration(
                color: backgroundColor5,
                borderRadius: BorderRadius.circular(10)),
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text(
              formLabel,
              style: const TextStyle(fontSize: 14),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            buttonHeight: 45,
            buttonPadding: const EdgeInsets.only(left: 10, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: validator,
            onChanged: onChanged
            //Do something when changing the item if you want.
            // widget.selectedDestination = value;
            ,
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
