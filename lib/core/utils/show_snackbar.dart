import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString(AppSecrets.tokenKey);
}
