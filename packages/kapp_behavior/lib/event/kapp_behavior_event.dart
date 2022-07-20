/// TODO:
/// Challenge rename to IKAppBehaviorEvent. Cause there is no interface in dart.
abstract class KAppBehaviorEvent {
  String get name;
  Map<String, dynamic>? get params;
  DateTime get timestamp;

  @override
  String toString() {
    return "[$name, $params, $timestamp]";
  }
}

class KAppBehaviorDefaultEvent with KAppBehaviorEvent {
  @override
  final String name;
  @override
  final Map<String, dynamic>? params;
  @override
  final DateTime timestamp;

  KAppBehaviorDefaultEvent(
    this.name, {
    this.params = const {},
  }) : timestamp = DateTime.now();
}

class KAppBehaviorScreenEvent implements KAppBehaviorEvent {
  @override
  final String name;
  @override
  final Map<String, dynamic>? params;
  @override
  final DateTime timestamp;

  KAppBehaviorScreenEvent.opened(
    String route,
    String screen,
  )   : name = 'screen_opened',
        timestamp = DateTime.now(),
        params = {'route': route, 'screen': screen};

  KAppBehaviorScreenEvent.closed(
    String route,
    String screen,
  )   : name = 'screen_closed',
        timestamp = DateTime.now(),
        params = {'route': route, 'screen': screen};
}
