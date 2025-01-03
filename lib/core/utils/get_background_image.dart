import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';

getBackgroundImage(String? profile_picture) {
    if (profile_picture == null) {
      return const AssetImage('images/man.png');
    } else {
      try {
        return NetworkImage('${AppSecrets.hostImageUrl}$profile_picture');
      } catch (e) {
        return const AssetImage('images/man.png');
      }
    }
  }