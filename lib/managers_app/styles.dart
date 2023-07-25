import 'package:flutter/material.dart';

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

var kHomeWidgetsBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 7),
    ]);

var kTextStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

var kTextStyle2 = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
