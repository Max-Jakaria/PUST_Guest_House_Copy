import 'package:flutter/material.dart';

class Separator {
  static Widget textField() {
    return const SizedBox(
      height: 20,
    );
  }

  static Widget percentage({required BuildContext context, required int p}) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * p/100.0),
    );
  }
}
