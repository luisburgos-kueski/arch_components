import 'package:flutter/material.dart';

import '../../utils/key_extension.dart';
import '../event/kevent_observer.dart';
import '../event/navigation/navigation_event.dart';
import '../observer_facade.dart';
import 'kueski_event_notifier.dart';

class NavigationNotifier extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const NavigationNotifier({
    required Key key,
    this.enabled = true,
    required this.child,
  }) : super(key: key);

  @override
  _NavigationNotifierState createState() => _NavigationNotifierState();
}

class _NavigationNotifierState extends State<NavigationNotifier>
    with RouteAware, KEventNotifier {
  @override
  bool get enabled => widget.enabled;

  @override
  KEventObserver get eventObserver => KLogBehavior.eventObserver;

  @override
  String get widgetId => widget.key.value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscribeRouteObserver();
  }

  @override
  void dispose() {
    KLogBehavior.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    notify(OnRoutePushed(widgetId: widgetId));
  }

  @override
  void didPop() {
    notify(OnRoutePopped(widgetId: widgetId));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => _subscribeRouteObserver(),
    );
    return widget.child;
  }

  void _subscribeRouteObserver() {
    debugPrint('$runtimeType _subscribeRouteObserver');
    var route = ModalRoute.of(context);
    if (route != null) {
      KLogBehavior.routeObserver.subscribe(this, route as PageRoute);
      debugPrint('$runtimeType _subscribeRouteObserver success');
    }
  }
}
