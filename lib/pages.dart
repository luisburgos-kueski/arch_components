import 'package:get/get.dart';
import 'package:home_feature/redirections.dart';
import 'package:home_feature/screen.dart';
import 'package:merchant_detail_feature/screen.dart';

import 'helpers/app_behavior_screen_wrapper.dart';

final List<GetPage> pages = [
  GetPage(
    name: HomeScreen.routeName,
    page: () {
      return HomeScreen(
        redirections: HomeRedirections(goToMerchantDetail: (merchantId) {
          Get.toNamed(MerchantDetailScreen.routeName.replaceAll(
            ':id',
            merchantId,
          ),);
        }, goToSettings: () {
          Get.toNamed(AppBehaviorScreenWrapper.routeName);
        }),
      );
    },
  ),
  GetPage(
    name: MerchantDetailScreen.routeName,
    page: () => const MerchantDetailScreen(),
  ),
  GetPage(
    name: AppBehaviorScreenWrapper.routeName,
    page: () => const AppBehaviorScreenWrapper(),
  ),
];
