import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

///TODO: Remove and change approach to stream navigation reaction.
class SplashPage extends StatelessWidget {
  static const routeName = '/';

  const SplashPage({
    Key? key,
    required this.homeRouteRedirect,
  }) : super(key: key);

  final String homeRouteRedirect;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Future.delayed(
        const Duration(seconds: 1),
        () => Get.offNamed(homeRouteRedirect),
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
