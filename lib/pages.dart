import 'package:arch_components/merchant_detail/page.dart';
import 'package:core/core.dart';
import 'package:get/get.dart';
import 'package:home_feature/redirections.dart';
import 'package:home_feature/screen.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import 'deprecated/home/screen.dart' as deprecated_home;

final List<GetPage> pages = [
  GetPage(
    name: TempStaticFeatureToggles.useHomeFeatureModule
        ? HomeScreen.routeName
        : deprecated_home.HomeScreen.routeName,
    page: () {
      if (TempStaticFeatureToggles.useHomeFeatureModule) {
        return HomeScreen(
          redirections: HomeRedirections(
            merchantDetailRoute: '/home/',
            settingsRoute: AppBehaviorScreen.routeName,
          ),
        );
      }
      return const deprecated_home.HomeScreen();
    },
  ),
  GetPage(
    name: MerchantDetailPage.routeName,
    page: () => const MerchantDetailPage(),
  ),
  GetPage(
    name: AppBehaviorScreen.routeName,
    page: () => AppBehaviorScreen(
      onBackPressed: () {
        OnBackPressedAppBehaviorNotifier().notifyOnBackPressed(
          fromRoute: Get.currentRoute,
        );
      },
    ),
  ),
];
