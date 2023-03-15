import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
            buttonStyleData: ButtonStyleData(decoration: BoxDecoration(
                color: backgroundColor5,
                borderRadius: BorderRadius.circular(10)),
            
              //Add more decoration as you want here
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
            onChanged: onChanged,
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
