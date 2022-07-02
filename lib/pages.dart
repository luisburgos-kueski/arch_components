import 'package:arch_components/home/page.dart';
import 'package:arch_components/home/shared/view_template.dart';
import 'package:arch_components/merchant_detail/page.dart';
import 'package:core/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import 'home/domain/load_merchants_use_case.dart';

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
        customColorDecorator: (event) {
          if (event is UseCaseKAppBehaviorEvent) {
            return Colors.yellow.shade300;
          }
          if (event is UiKAppBehaviorEvent) {
            return Colors.blue.shade300;
          }
          if (event is KScreenEvent) {
            return Colors.green.shade300;
          }
          return Colors.grey;
        },
      ),
    ),
  ),
];
