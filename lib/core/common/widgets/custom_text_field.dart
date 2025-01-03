import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final int? maxLines;
  const MyTextField({super.key, required this.hintText, required this.labelText, required this.controller, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '${labelText} is being required.';
        }
        return null;
      },
    );
  }
}
