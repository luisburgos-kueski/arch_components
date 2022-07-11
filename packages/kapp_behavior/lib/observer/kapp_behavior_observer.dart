import 'package:flutter/material.dart';

import '../event/kapp_behavior_event.dart';
import '../notifier/kapp_behavior_notifier.dart';

abstract class KAppBehaviorEventObserver {
  void onEvent(KAppBehaviorEvent event);
}

// TODO:
// Validate how to use a contract for the route when dealing with
// MaterialPageRoute, GetPageRoute or any other library custom component.
class KAppBehaviorRouteToScreenObserver extends RouteObserver<PageRoute<dynamic>>
    with KAppBehaviorScreenNotifier {
  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: Implement notify
    // TODO: Verify integration with KScreenRouteObserver class.
    super.didPush(route, previousRoute);
  }
}
