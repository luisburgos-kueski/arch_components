import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import 'redirections.dart';
import 'view/bloc/bloc_view.dart';
import 'view/getx/controller_view.dart';
import 'view/riverpod/riverpod_view.dart';

/// Extending from [KAppBehaviorRouteAwareScreen] allows this `Screen` to notify about
/// [KAppBehaviorScreenEvent].
class HomeScreen extends KAppBehaviorRouteAwareScreen {
  static const routeName = '/home';
  static const screenName = 'HomeScreen';

  const HomeScreen({
    Key? key,
    required this.redirections,
  }) : super(
          key: key,
          route: routeName,
          name: screenName,
        );

  final HomeRedirections redirections;

  @override
  KRouteAwareState<KAppBehaviorRouteAwareScreen> createState() =>
      _HomeScreenState();
}

/// By using [NavigationNotifier] widget wrapper this `Screen` can notify about
/// [NavigationEvent]s.
class _HomeScreenState extends KRouteAwareState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO: Verify snake case nomenclature.
    return NavigationNotifier(
      key: const Key('home_screen'),
      child: LogBehaviorTrackedHomeScreen(
        redirections: widget.redirections,
      ),
    );
  }
}

///TODO: Rename to HomeScreenLogBehaviorNotifier
class LogBehaviorTrackedHomeScreen extends StatelessWidget {
  const LogBehaviorTrackedHomeScreen({
    Key? key,
    required this.redirections,
  }) : super(key: key);

  final HomeRedirections redirections;

  @override
  Widget build(BuildContext context) {
    /// We could inject feature flags from this point of the
    /// widget tree, through a `ScreenController` if needed.
    ///
    /// Example:
    /// Use of feature toggles to perform view migrations.
    if (TempStaticFeatureToggles.useBloc) {
      return Scaffold(body: HomeBlocView(redirections));
    }

    if (TempStaticFeatureToggles.useRiverpod) {
      return Scaffold(body: HomeRiverpodView(redirections));
    }

    return Scaffold(body: HomeControllerView(redirections));
  }
}
