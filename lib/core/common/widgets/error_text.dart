import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          text,
          style: TextStyle(color: AppPallete.dangerColor),
        )),
      ],
    );
  }
}
