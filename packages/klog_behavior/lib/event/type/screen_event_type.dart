import 'event_type.dart';

@Deprecated('Will be removed in v2.0')
enum ScreenEventEnum {
  screenOpened,
  screenClosed,
}

@Deprecated('Will be removed in v2.0')
class ScreenEventType implements EventType {
  final String _name;

  static final Map<ScreenEventEnum, ScreenEventType> _cache =
      <ScreenEventEnum, ScreenEventType>{};

  static ScreenEventType _getScreenEventType({required ScreenEventEnum type}) {
    if (_cache.containsKey(type)) {
      return _cache[type]!;
    }
    final ScreenEventType instance = ScreenEventType._internal(name: type.name);
    _cache[type] = instance;
    return instance;
  }

  factory ScreenEventType.opened() {
    return _getScreenEventType(type: ScreenEventEnum.screenOpened);
  }

  factory ScreenEventType.closed() {
    return _getScreenEventType(type: ScreenEventEnum.screenClosed);
  }

  ScreenEventType._internal({required String name}) : _name = name;

  @override
  String get name => _name;
}
