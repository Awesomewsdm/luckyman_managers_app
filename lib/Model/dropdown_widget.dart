import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:luckyman_managers_app/constants/colors.dart';
import 'text_style.dart';

class BookingDropdownMenu extends StatelessWidget {
  const BookingDropdownMenu({
    Key? key,
    required this.items,
    required this.formLabel,
    // this.buttonWidth,
    this.formKey,
    this.onSaved,
    this.onChanged,
    this.validator,
    required this.dropdownTitle,
  }) : super(key: key);

  final List<dynamic> items;
  final String formLabel;
  // final double? buttonWidth;
  final Key? formKey;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
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
            // buttonWidth: buttonWidth,

            buttonDecoration: BoxDecoration(
                color: backgroundColor5,
                borderRadius: BorderRadius.circular(10)),
            decoration: const InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
            ),
            isExpanded: true,
            hint: Text(
              formLabel,
              style: const TextStyle(fontSize: 14),
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
            onChanged: onChanged,
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
