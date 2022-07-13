import '../event/event.dart';
import '../manager/event_manager.dart';

@Deprecated('Use [KEventNotifier]')
abstract class EventTracker {
  bool get enabled;
  EventManager? get manager;
  void trackEvent(LogBehaviorEvent event) {
    if (enabled) {
      manager?.log(event);
    }
  }
}
