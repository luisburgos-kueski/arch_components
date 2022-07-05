import 'package:arch_components/home/page.dart';
import 'package:arch_components/merchant_detail/page.dart';
import 'package:core/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

final List<GetPage> pages = [
  GetPage(
    name: HomePage.routeName,
    page: () => const HomePage(),
  ),
  GetPage(
    name: MerchantDetailPage.routeName,
    page: () => const MerchantDetailPage(),
  ),
  GetPage(
    name: AppBehaviorScreen.routeName,
    page: () => BaseScaffold(
      appBar: AppBar(
        title: const Text(
          AppBehaviorScreen.routeName,
        ),
      ),
      body: AppBehaviorScreen(
        onBackPressed: () {
          KAppBehavior.registerEvent(
            CustomNavigateBackAppBehaviorEvent(
              from: Get.currentRoute,
            ),
          );
        },
      ),
    ),
  ),
];

class CustomNavigateBackAppBehaviorEvent implements KDefaultAppBehaviorEvent {
  @override
  String get name => 'custom_navigate_back';

  @override
  Map<String, dynamic>? get params => {
        'from_route': from,
      };

  @override
  final DateTime timestamp;

  final String from;

  CustomNavigateBackAppBehaviorEvent({
    required this.from,
  }) : timestamp = DateTime.now();
}
