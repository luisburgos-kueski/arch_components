import 'event.dart';
import 'type/component_type.dart';
import 'type/event_type.dart';
import 'type/screen_event_type.dart';

@Deprecated('Will be removed in v2.0')
class ScreenEvent with LogBehaviorEvent {
  final String _id;
  final ComponentType _componentType;
  final ScreenEventType _screenEventType;
  final DateTime _timestamp;
  final Map<String, dynamic> _data;
  final Map<String, dynamic> _metadata;

  ScreenEvent({
    required String id,
    required ScreenEventType screenEventType,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = id,
        _componentType = ComponentType.screen,
        _screenEventType = screenEventType,
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  ScreenEvent.opened({
    required String componentId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = componentId,
        _componentType = ComponentType.screen,
        _screenEventType = ScreenEventType.opened(),
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  ScreenEvent.closed({
    required String componentId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = componentId,
        _componentType = ComponentType.screen,
        _screenEventType = ScreenEventType.closed(),
        _timestamp = DateTime.now(),
        _data = data ?? {},
        _metadata = metadata ?? {};

  @override
  String get componentId => _id;

  @override
  EventType get eventType => _screenEventType;

  @override
  ComponentType get componentType => _componentType;

  @override
  DateTime get timestamp => _timestamp;

  @override
  Map<String, dynamic> get data => _data;

  @override
  Map<String, dynamic> get metadata => _metadata;
}
