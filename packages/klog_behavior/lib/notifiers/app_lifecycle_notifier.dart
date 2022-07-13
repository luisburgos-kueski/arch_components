import 'package:flutter/material.dart';

import '../../event/lifecycle/lifecycle_event.dart';
import '../../utils/key_extension.dart';
import '../event/kevent_observer.dart';
import '../observer_facade.dart';
import 'kueski_event_notifier.dart';

class AppLifecycleNotifier extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const AppLifecycleNotifier({
    required Key key,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AppLifecycleNotifier> createState() => _AppLifecycleNotifierState();
}

class _AppLifecycleNotifierState extends State<AppLifecycleNotifier>
    with WidgetsBindingObserver, KEventNotifier {
  @override
  String get widgetId => widget.key.value;

  @override
  bool get enabled => widget.enabled;

  @override
  KEventObserver get eventObserver => KLogBehavior.eventObserver;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        notify(OnAppResumed(widgetId: widgetId));
        break;
      case AppLifecycleState.inactive:
        notify(OnAppInactive(widgetId: widgetId));
        break;
      case AppLifecycleState.paused:
        notify(OnAppPaused(widgetId: widgetId));
        break;
      case AppLifecycleState.detached:
        notify(OnAppDetached(widgetId: widgetId));
        break;
    }
  }
}
