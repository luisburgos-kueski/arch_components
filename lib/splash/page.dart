import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

///TODO: Remove and change approach to stream navigation reaction.
class SplashPage extends StatelessWidget {
  static const routeName = '/';

  const SplashPage({
    Key? key,
    required this.onRedirectTo,
  }) : super(key: key);

  final Function() onRedirectTo;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Future.delayed(
        const Duration(seconds: 1),
        () => onRedirectTo(),
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
