import 'event.dart';
import 'type/component_type.dart';
import 'type/event_type.dart';
import 'type/widget_event_type.dart';

@Deprecated('Will be removed in v2.0')
class WidgetEvent with LogBehaviorEvent {
  final String _id;
  final ComponentType _componentType;
  final WidgetEventType _widgetEventType;
  final DateTime _timestamp;
  final Map<String, dynamic> _data;
  final Map<String, dynamic> _metadata;

  WidgetEvent({
    required String id,
    required ComponentType componentType,
    required WidgetEventType widgetEventType,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  })  : _id = id,
        _componentType = componentType,
        _widgetEventType = widgetEventType,
        _timestamp = DateTime.now(),
        _data = data ?? const {},
        _metadata = metadata ?? const {};

  @override
  String get componentId => _id;

  @override
  EventType get eventType => _widgetEventType;

  @override
  ComponentType get componentType => _componentType;

  @override
  DateTime get timestamp => _timestamp;

  @override
  Map<String, dynamic> get data => _data;

  @override
  Map<String, dynamic> get metadata => _metadata;
}
