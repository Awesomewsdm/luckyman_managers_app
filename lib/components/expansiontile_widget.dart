import 'package:flutter/material.dart';

class TileChildrenWidget extends StatelessWidget {
  const TileChildrenWidget({
    super.key,
    required this.firstDescription,
    required this.firstTitle,
    this.secondDescription,
    this.secondTitle,
  });

  final String firstDescription;
  final String firstTitle;
  final String? secondTitle;
  final String? secondDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
            softWrap: true,
            TextSpan(text: firstTitle, children: [
              TextSpan(
                text: " $firstDescription",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ])),
        const SizedBox(
          width: 10.0,
        ),
        Text.rich(
            softWrap: true,
            TextSpan(text: secondTitle, children: [
              TextSpan(
                text: " $secondDescription",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ])),
      ],
    );
  }
}
