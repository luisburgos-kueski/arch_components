import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import '../home/page.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Future.delayed(
        const Duration(seconds: 3),
        () => Get.offNamed(HomePage.routeName),
      ),
    );
    return const NavigationNotifier(
      key: Key('splash_screen'),
      child: Scaffold(
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
