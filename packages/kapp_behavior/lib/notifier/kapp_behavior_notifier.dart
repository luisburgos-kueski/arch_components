import '../event/kapp_behavior_event.dart';
import '../kapp_behavior_2.dart';

abstract class KAppBehaviorEventNotifier {
  void notify(KAppBehaviorEvent2 event) {
    KAppBehavior2.observer.onEvent(event);
  }
}
