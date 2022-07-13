import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in v2.0')
class RouteObserverProvider extends StatelessWidget {
  final RouteObserver<PageRoute> observer;
  final Widget child;

  const RouteObserverProvider({
    Key? key,
    required this.observer,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => observer,
      child: child,
    );
  }
}
