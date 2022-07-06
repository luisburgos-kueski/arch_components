import 'package:flutter/material.dart';

/// Taken from kueski-os KScreenNavigationObserver class. Thanks Sergio.
///
/// Navigation observer that encapsulates the route logic and transforms it
/// into [onScreenAttached], [onScreenDetached], [onScreenPaused] and
/// [onScreenResumed]
class KScreenRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      onScreenAttached(route);
    }
    if (previousRoute != null && previousRoute is PageRoute) {
      onScreenPaused(previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      onScreenAttached(newRoute);
    }
    if (oldRoute != null && oldRoute is PageRoute) {
      onScreenDetached(oldRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null && previousRoute is PageRoute) {
      onScreenResumed(previousRoute);
    }
    if (route is PageRoute) {
      onScreenDetached(route);
    }
  }

  /// Triggered when a screen is opened for the first time (eg. pushed into the stack, replaced the current screen)
  void onScreenAttached(Route route) {}

  /// Triggered when a screen is sent back into the stack (eg. new screen is pushed into the stack)
  void onScreenPaused(Route route) {}

  /// Triggered when a screen is sent to the top of the stack (eg. screen on top of the stack pops, resuming the previous one in the stack)
  void onScreenResumed(Route route) {}

  /// Triggered when a screen is completely closed/disposed (eg. pops from the stack, replaced by another screen)
  void onScreenDetached(Route route) {}
}
