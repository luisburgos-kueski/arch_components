import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../kapp_behavior.dart';

abstract class KAppBehaviorScreenIdentifiable {
  String get route;
  String get name;
}

/// TODO: Validate with tabs
/// Widget - Tabs **
/// KTrackedScreen
/// bottom nav controller / notifier
/// notify()
abstract class KAppBehaviorRouteAwareScreen extends StatefulWidget
    implements KAppBehaviorScreenIdentifiable {
  const KAppBehaviorRouteAwareScreen({
    Key? key,
    required this.route,
    required this.name,
  }) : super(key: key);
  @override
  final String route;
  @override
  final String name;

  @override
  KRouteAwareState<KAppBehaviorRouteAwareScreen> createState();
}

abstract class KRouteAwareState<T extends KAppBehaviorRouteAwareScreen>
    extends State<T>
    with RouteAware, AfterLayoutMixin<T>, KAppBehaviorScreenNotifier {
  bool enteredScreen = false;

  @override
  @mustCallSuper
  void afterFirstLayout(BuildContext context) {
    if (mounted) {
      KAppBehavior.routeObserver.subscribe(
        this,
        ModalRoute.of(context) as PageRoute,
      );
      Timer.run(_enterScreen);
    }
  }

  void _enterScreen() {
    onEnterScreen();
    enteredScreen = true;
  }

  void _leaveScreen() {
    onLeaveScreen();
    enteredScreen = false;
  }

  @override
  @mustCallSuper
  void dispose() {
    if (enteredScreen) {
      _leaveScreen();
    }
    KAppBehavior.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  @mustCallSuper
  void didPopNext() {
    Timer.run(_enterScreen);
  }

  @override
  @mustCallSuper
  void didPop() {
    _leaveScreen();
  }

  @override
  @mustCallSuper
  void didPushNext() {
    _leaveScreen();
  }

  void onEnterScreen() {
    notifyNavigation(KAppBehaviorScreenEvent.opened(widget.route, widget.name));
  }

  void onLeaveScreen() {
    notifyNavigation(KAppBehaviorScreenEvent.closed(widget.route, widget.name));
  }
}
