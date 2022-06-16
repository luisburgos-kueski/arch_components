import 'package:arch_components/home/state/bloc.dart';
import 'package:arch_components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/bloc_view.dart';
import 'view/controller_view.dart';
import 'view/riverpod_view.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (TempStaticFeatureToggles.useBloc) {
      return Scaffold(
        body: BlocProvider(
          create: (_) => HomeBloc(),
          child: const HomeBlocView(),
        ),
      );
    }

    if (TempStaticFeatureToggles.useRiverpod) {
      return const Scaffold(body: HomeRiverpodView());
    }

    return const Scaffold(body: HomeControllerView());
  }
}
