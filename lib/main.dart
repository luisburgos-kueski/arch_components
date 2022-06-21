import 'dart:developer' as dev;

import 'package:arch_components/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kevent_tracker/kevent_tracker.dart';
import 'package:kufemia/kufemia.dart';

import 'bloc_observer.dart';
import 'splash/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KEventTracker.init(
    observerFacade: ObserverFacade(
      routeObserver: MyRouteObserver(),
      eventObserver: MyEventObserver(),
    ),
  );

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyEventObserver extends KEventObserver {
  @override
  void onEvent(KEvent event) {
    dev.log(event.toString());
  }
}

class MyRouteObserver extends KRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    dev.log("$runtimeType didPush: $route");
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    dev.log("$runtimeType didPop: $route");
    super.didPop(route, previousRoute);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KueskiApp(
      data: KueskiData(
        palette: KueskiPaletteData.kueski(),
        spacing: KueskiSpacingData.fallback(),
        button: KueskiButtonThemeData.fallback(),
        darkPalette: KueskiPaletteData.kueski(),
      ),
      child: AppLifecycleNotifier(
        key: const Key('app_v1'),
        child: ProviderScope(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Event Tracker Example',
            themeMode: ThemeMode.dark,
            home: const SplashPage(),
            getPages: pages,
            navigatorObservers: [
              MyRouteObserver(),
            ],
          ),
        ),
      ),
    );
  }
}
