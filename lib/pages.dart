import 'package:arch_components/merchant_detail/page.dart';
import 'package:get/get.dart';
import 'package:home_feature/redirections.dart';
import 'package:home_feature/screen.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

final List<GetPage> pages = [
  GetPage(
    name: HomeScreen.routeName,
    page: () {
      return HomeScreen(
        redirections: HomeRedirections(
          merchantDetailRoute: '/home/',
          settingsRoute: AppBehaviorScreen.routeName,
        ),
      );
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
