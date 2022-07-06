import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'view/bloc_view.dart';
import 'view/controller_view.dart';
import 'view/riverpod_view.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

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
