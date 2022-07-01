import 'package:flutter/material.dart';

class KMessenger {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}

class TempStaticFeatureToggles {
  static bool useBloc = true;
  static bool useRiverpod = false;
}
