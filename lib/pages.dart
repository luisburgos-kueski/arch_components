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
      body: const AppBehaviorScreen(),
    ),
  ),
];
