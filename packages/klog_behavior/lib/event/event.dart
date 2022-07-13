import 'type/component_type.dart';
import 'type/event_type.dart';

@Deprecated('Will be removed in v2.0')
enum Source { logBehavior, appBehavior }

@Deprecated('Will be removed in v2.0')
abstract class Event {
  String get name;
  Source get source;
  DateTime get timestamp;
  Map<String, dynamic> get payload;
  Map<String, dynamic> get metadata;
}

@Deprecated('Will be removed in v2.0')
extension EventFormatter on Event {
  String format() {
    var event =
        "Name: $name, Time: $timestamp, Source: ${source.name} Payload: [";
    payload.forEach((key, value) => event += '($key: $value)');
    event += "], Metadata: [";
    metadata.forEach((key, value) => event += '($key: $value)');
    event += "]";
    return event;
  }
}

/// Id Generation //
/// [componentId] Unique component id
/// [timestamp] Time of the event
@Deprecated('Will be removed in v2.0')
abstract class LogBehaviorEvent implements Event {
  String get componentId;
  EventType get eventType;
  ComponentType get componentType;

  /// Additional [data] to be added to the payload
  Map<String, dynamic> get data;

  @override
  String get name => eventType.name;

  @override
  Source get source => Source.logBehavior;

  @override
  Map<String, dynamic> get payload {
    Map<String, dynamic> params = {
      'componentId': componentId,
      'componentType': componentType.name,
    };
    params.addAll(data);
    return params;
  }
}

@Deprecated('Will be removed in v2.0')
class AppBehaviorEvent implements Event {
  final String _name;
  final DateTime _timestamp;
  final Map<String, dynamic> _payload;
  final Map<String, dynamic> _metadata;

  AppBehaviorEvent({
    required String name,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? metadata,
  })  : _name = name,
        _timestamp = DateTime.now(),
        _payload = payload ?? const {},
        _metadata = metadata ?? const {};

  @override
  String get name => _name;

  @override
  Source get source => Source.appBehavior;

  @override
  Map<String, dynamic> get payload => _payload;

  @override
  DateTime get timestamp => _timestamp;

  @override
  Map<String, dynamic> get metadata => _metadata;
}
