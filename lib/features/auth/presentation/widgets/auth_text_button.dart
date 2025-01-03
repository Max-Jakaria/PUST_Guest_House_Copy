import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final String boldedText;
  final VoidCallback onPressed;
  const AuthTextButton({
    super.key,
    required this.text,
    required this.boldedText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppPallete.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          Text(
            boldedText,
            style: const TextStyle(
              color: AppPallete.primaryDeep,
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
