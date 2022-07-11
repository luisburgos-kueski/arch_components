import 'package:flutter/material.dart';

import '../event/kapp_behavior_event.dart';
import '../notifier/kapp_behavior_notifier.dart';

abstract class KAppBehaviorEventObserver {
  void onEvent(KAppBehaviorEvent event);
}

// TODO: Validate how use a contract for the route using MaterialPageRoute and GetPageRoute
// TODO: Rename to KAppScreenNavigationObserver
class KAppBehaviorRouteObserver extends RouteObserver<PageRoute<dynamic>>
    with KAppBehaviorScreenNotifier {
  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: Implement notify
    super.didPush(route, previousRoute);
  }
}
