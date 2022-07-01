import '../kapp_behavior.dart';

abstract class KAppBehaviorEventNotifier {
  void notify(KAppBehaviorEvent event) {
    KAppBehavior.observer.onEvent(event);
  }
}
