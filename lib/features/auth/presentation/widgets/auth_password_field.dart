import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  const AuthPasswordField(
      {super.key, required this.labelText, required this.hintText, required this.controller});

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _togglePasswordVisibility,
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '${widget.labelText} field required.';
        } else if (value.length < 6) {
          return 'Password at least 6 character';
        }
        return null;
      },
    );
  }
}
