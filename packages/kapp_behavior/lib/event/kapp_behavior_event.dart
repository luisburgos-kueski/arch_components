/// TODO: Should this be non-abstract? So we can have named constructors?
abstract class KAppBehaviorEvent {
  String get name;
  Map<String, dynamic>? get params;
  DateTime get timestamp;

  @override
  String toString() {
    ///TODO: Should we add timestamp here?
    return "[$name, $params]";
  }
}

class KDefaultAppBehaviorEvent with KAppBehaviorEvent {
  @override
  final String name;
  @override
  final Map<String, dynamic>? params;
  @override
  final DateTime timestamp;

  KDefaultAppBehaviorEvent(
    this.name, {
    this.params = const {},
  }) : timestamp = DateTime.now();
}

class KScreenEvent with KAppBehaviorEvent {
  @override
  final String name;
  @override
  final Map<String, dynamic>? params;
  @override
  final DateTime timestamp;

  KScreenEvent.opened(
    String route,
    String screen,
  )   : name = 'screen_opened',
        timestamp = DateTime.now(),
        params = {'route': route, 'screen': screen};

  KScreenEvent.closed(
    String route,
    String screen,
  )   : name = 'screen_closed',
        timestamp = DateTime.now(),
        params = {'route': route, 'screen': screen};
}
