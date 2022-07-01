import 'package:flutter/material.dart';

import '../event/kapp_behavior_event.dart';
import '../notifier/kapp_behavior_notifier.dart';

abstract class KAppEventObserver {
  void onEvent(KAppBehaviorEvent event);
}

// TODO: Validate how use a contract for the route using MaterialPageRoute and GetPageRoute
class KAppRouteObserver extends RouteObserver<PageRoute<dynamic>>
    with KAppBehaviorEventNotifier {
  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: Implement notify
    super.didPush(route, previousRoute);
  }
}
