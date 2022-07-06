import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import 'view/bloc/bloc_view.dart';
import 'view/getx/controller_view.dart';
import 'view/riverpod/riverpod_view.dart';

@Deprecated('Use packages/home components instead')
class HomeScreen extends KRouteAwareScreen {
  static const routeName = '/home';
  static const screenName = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(
          key: key,
          route: routeName,
          name: screenName,
        );

  @override
  KRouteAwareState<KRouteAwareScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends KRouteAwareState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (TempStaticFeatureToggles.useBloc) {
      return const Scaffold(body: HomeBlocView());
    }

    if (TempStaticFeatureToggles.useRiverpod) {
      return const Scaffold(body: HomeRiverpodView());
    }

    return const Scaffold(body: HomeControllerView());
  }
}
