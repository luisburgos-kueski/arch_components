import 'event_type.dart';

@Deprecated('Will be removed in v2.0')
enum AppEventEnum {
  appPaused,
  appResumed,
  appInactive,
  appDetached,
}

@Deprecated('Will be removed in v2.0')
class AppEventType implements EventType {
  final String _name;

  static final Map<AppEventEnum, AppEventType> _cache =
      <AppEventEnum, AppEventType>{};

  static AppEventType _getAppEventType({required AppEventEnum type}) {
    if (_cache.containsKey(type)) {
      return _cache[type]!;
    }
    final AppEventType instance = AppEventType._internal(name: type.name);
    _cache[type] = instance;
    return instance;
  }

  factory AppEventType.resumed() {
    return _getAppEventType(type: AppEventEnum.appResumed);
  }

  factory AppEventType.detached() {
    return _getAppEventType(type: AppEventEnum.appDetached);
  }

  factory AppEventType.inactive() {
    return _getAppEventType(type: AppEventEnum.appInactive);
  }

  factory AppEventType.paused() {
    return _getAppEventType(type: AppEventEnum.appPaused);
  }

  AppEventType._internal({required String name}) : _name = name;

  @override
  String get name => _name;
}
