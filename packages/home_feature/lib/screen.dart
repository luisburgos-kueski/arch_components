import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import 'redirections.dart';
import 'view/bloc/bloc_view.dart';
import 'view/getx/controller_view.dart';
import 'view/riverpod/riverpod_view.dart';

class HomeScreen extends KRouteAwareScreen {
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
  KRouteAwareState<KRouteAwareScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends KRouteAwareState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (TempStaticFeatureToggles.useBloc) {
      return Scaffold(body: HomeBlocView(widget.redirections));
    }

    if (TempStaticFeatureToggles.useRiverpod) {
      return Scaffold(body: HomeRiverpodView(widget.redirections));
    }

    return Scaffold(body: HomeControllerView(widget.redirections));
  }
}
