import 'dart:developer';

import '../kapp_behavior.dart';

abstract class KAppBehaviorEventNotifier {
  void notifyAppBehavior(KAppBehaviorEvent event) {
    log(
      '$runtimeType - $event',
      name: 'APP_BEHAVIOR',
    );
    KAppBehavior.registerEvent(event);
  }
}
