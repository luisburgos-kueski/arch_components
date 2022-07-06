import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'redirections.dart';
import 'view/bloc/bloc_view.dart';
import 'view/getx/controller_view.dart';
import 'view/riverpod/riverpod_view.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({
    Key? key,
    required this.redirections,
  }) : super(key: key);

  final HomeRedirections redirections;

  @override
  Widget build(BuildContext context) {
    if (TempStaticFeatureToggles.useBloc) {
      return Scaffold(body: HomeBlocView(redirections));
    }

    if (TempStaticFeatureToggles.useRiverpod) {
      return Scaffold(body: HomeRiverpodView(redirections));
    }

    return Scaffold(body: HomeControllerView(redirections));
  }
}
