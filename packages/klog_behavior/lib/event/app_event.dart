import 'event.dart';
import 'type/app_event_type.dart';
import 'type/component_type.dart';
import 'type/event_type.dart';

@Deprecated('Will be removed in v2.0')
class AppEvent with LogBehaviorEvent {
  final String _id;
  final AppEventType _appEventType;
  final ComponentType _componentType;
  final DateTime _timestamp;

  /// Additional [data] for payload
  final Map<String, dynamic> _data;
  final Map<String, dynamic> _metadata;

  AppEvent({
    required String id,
    required AppEventType appEventType,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = id,
        _componentType = ComponentType.app,
        _timestamp = DateTime.now(),
        _appEventType = appEventType,
        _data = data ?? {},
        _metadata = metadata ?? {};

  AppEvent.paused({
    required String componentId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = componentId,
        _componentType = ComponentType.app,
        _appEventType = AppEventType.paused(),
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  AppEvent.resumed({
    required String componentId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = componentId,
        _componentType = ComponentType.app,
        _appEventType = AppEventType.resumed(),
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  AppEvent.inactive({
    required String componentId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = componentId,
        _componentType = ComponentType.app,
        _appEventType = AppEventType.inactive(),
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  AppEvent.detached({
    required String componentId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = componentId,
        _appEventType = AppEventType.paused(),
        _componentType = ComponentType.app,
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  @override
  String get componentId => _id;

  @override
  EventType get eventType => _appEventType;

  @override
  ComponentType get componentType => _componentType;

  @override
  DateTime get timestamp => _timestamp;

  @override
  Map<String, dynamic> get data => _data;

  @override
  Map<String, dynamic> get metadata => _metadata;
}
