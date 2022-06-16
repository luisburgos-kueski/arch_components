import 'package:arch_components/home/bloc.dart';
import 'package:arch_components/home/controller_view.dart';
import 'package:arch_components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_view.dart';

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

    return const Scaffold(body: HomeControllerView());
  }
}
