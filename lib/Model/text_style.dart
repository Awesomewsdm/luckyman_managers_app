import 'package:flutter/material.dart';

class AshTextWidget extends StatelessWidget {
  const AshTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 14.0, this.fontWeight,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(255, 77, 69, 69),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}


class BlackTextWidget extends StatelessWidget {
  const BlackTextWidget({
    Key? key,
    required this.text,
    this.fontSize,
    this.color = const Color(0xFF000000),
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

}