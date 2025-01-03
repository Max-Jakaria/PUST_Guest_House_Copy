import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class PageTitle extends StatelessWidget {
  final String text;
  const PageTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: AppPallete.black,
      ),
    );
  }
}
