import '../type/component_type.dart';
import '../type/widget_event_type.dart';

@Deprecated('Will be removed in v2.0')
abstract class OnWidgetEventListener {
  void onEvent({
    required ComponentType componentType,
    required WidgetEventType eventType,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  });
}
