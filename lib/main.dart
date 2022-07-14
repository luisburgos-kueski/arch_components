import 'package:arch_components/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:klog_behavior/klog_behavior.dart';

import 'helpers/app_behavior_observers.dart';
import 'helpers/bloc_to_app_behavior_notifier.dart';
import 'helpers/log_behavior_observers.dart';
import 'splash/page.dart';

final kMyRouteObserver = MyRouteObserver();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KLogBehavior.init(
    observerFacade: ObserverFacade(
      routeObserver: kMyRouteObserver,
      eventObserver: MyEventObserver(),
    ),
  );

  KAppBehavior.init(
    eventObserver: const KDefaultAppObserver(),
  );

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: BlocToAppBehaviorEventNotifier(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLifecycleNotifier(
      key: const Key('arch_components'),
      child: ProviderScope(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Architecture Components',
          themeMode: ThemeMode.dark,
          home: SplashPage(
            onRedirectTo: () {
              throw Exception('Intentional bug on main repo');
              //Get.offNamed(HomeScreen.routeName);
            },
          ),
          getPages: pages,
          navigatorObservers: [
            kMyRouteObserver,
          ],
        ),
      ),
    );
  }
}
