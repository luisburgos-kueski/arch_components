abstract class KAppBehaviorEvent2 {
  String get name;

  Map<String, dynamic>? get params;

  DateTime get timestamp;

  @override
  String toString() {
    return "[$name, $params]";
  }
}

class KScreenEvent with KAppBehaviorEvent2 {
  @override
  final String name;
  @override
  final Map<String, dynamic> params;
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
