import 'package:arch_components/deprecated/home/screen.dart';
import 'package:arch_components/merchant_detail/page.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

final List<GetPage> pages = [
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
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
