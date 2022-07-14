// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class TrackedScreen {
  String get routeName;

  String get className;
}

class LoginScreen extends StatelessWidget implements TrackedScreen {
  static const String route = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  String get className => runtimeType.toString();

  @override
  String get routeName => route;

  @override
  Widget build(BuildContext context) {
    throw Container();
  }
}

void main() {
  const TrackedScreen screen = LoginScreen();
  test(
    "test contract",
    () {
      expect(screen.routeName, LoginScreen.route);
      expect(screen.className, 'LoginScreen');
    },
  );
}
