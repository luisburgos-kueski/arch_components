import 'package:flutter/material.dart';
import 'package:klog_behavior/klog_behavior.dart';

import '../tools/klogger.dart';

class MyEventObserver extends KEventObserver {
  @override
  void onEvent(KEvent event) {
    KLogger.log(event.toString(), 'LB-OBSERVER');
  }
}

class MyRouteObserver extends KRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    KLogger.log('$runtimeType didPush: $route', 'LB-OBSERVER');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    KLogger.log('$runtimeType didPop: $route', 'LB-OBSERVER');
    super.didPop(route, previousRoute);
  }
}
