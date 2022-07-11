import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_feature/redirections.dart';
import 'package:home_feature/screen.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchant_detail_feature/screen.dart';

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
    name: MerchantDetailScreen.routeName,
    page: () => const MerchantDetailScreen(),
  ),
  GetPage(
    name: AppBehaviorScreen.routeName,
    page: () => const _AppBehaviorScreenWrapper(),
  ),
];

//TODO: Evaluate move to own folder.
class _AppBehaviorScreenWrapper extends StatelessWidget
    with OnBackPressedAppBehaviorNotifier {
  const _AppBehaviorScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBehaviorScreen(
      onBackPressed: () {
        notifyOnBackPressed(
          fromRoute: Get.currentRoute,
        );
      },
    );
  }
}
