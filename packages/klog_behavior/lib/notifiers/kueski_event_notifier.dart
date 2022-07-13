import '../event/k_event.dart';
import '../event/kevent_observer.dart';
import '../klog_behavior.dart';

abstract class KEventNotifier {
  // TODO: PRODUCT-12283 Validate that key is never null when we make the field required
  String get widgetId;

  bool get enabled;

  KEventObserver get eventObserver;

  void notify(KEvent event) {
    if (enabled) {
      eventObserver.onEvent(event);
      KLogBehavior.eventsStore.add(event);
    }
  }
}
