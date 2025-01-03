import 'package:flutter/material.dart';

class AppPallete {
  static const Color backgroundColor = Color.fromRGBO(10, 100, 100, 100);
  static const Color primary = Color(0xFF29B6F6);
  static const Color primaryLight = Color(0xFF81D4FA);
  static const Color primaryExtraLight = Color(0xFFE1F5FE);
  static const Color primaryDeep = Color(0xFF039BE5);
  static const Color primaryExtraDeep = Color(0xFF01579B);

  static const Color dangerColor = Color(0xFFEF5350);
  static const Color acceptColor = Color(0xFF4CAF50);

  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color whiteLight = Color.fromARGB(180, 255, 255, 255);

  static Color seenPendingColor = Colors.yellow.shade50;
  static Color seenApprovedColor = Colors.blue.shade50;
  static Color seenRejectedColor = Colors.red.shade100;
  static Color unSeenPendingColor = Colors.yellow.shade200;
  static Color unSeenApprovedColor = Colors.blue.shade200;
  static Color unSeenRejectedColor = Colors.red.shade200;
}
