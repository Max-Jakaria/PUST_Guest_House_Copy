import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

Widget home_background({required Widget child}) {
  return Container(
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: AppPallete.white),
          alignment: Alignment.bottomCenter,
          // Background
          child: Opacity(
            opacity: 0.2,
            child: Image.asset('images/home_illustrator.png'),
          ),
          // Lgin UI
        ),
        child,
      ],
    ),
  );
}
