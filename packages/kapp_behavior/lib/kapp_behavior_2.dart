import 'observer/kapp_behavior_observer.dart';

abstract class KAppBehavior2 {
  static void init(
    KAppEventObserver eventObserver,
    KAppRouteObserver routeObserver,
  ) {
    _observer = eventObserver;
    _routeObserver = routeObserver;
  }

  static KAppEventObserver? _observer;
  static KAppRouteObserver? _routeObserver;

  static KAppEventObserver get observer {
    if (_observer == null) throw Exception();
    return _observer!;
  }

  static KAppRouteObserver get routeObserver {
    if (_routeObserver == null) throw Exception();
    return _routeObserver!;
  }
}
