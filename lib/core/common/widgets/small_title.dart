import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class SmallTitle extends StatelessWidget {
  final String title;
  const SmallTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppPallete.black,
      ),
    );
  }
}
