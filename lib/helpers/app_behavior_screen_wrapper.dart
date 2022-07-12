//TODO: Evaluate move to own folder.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

class AppBehaviorScreenWrapper extends StatelessWidget
    with KAppBehaviorOnBackPressedNotifier {
  static const String routeName = AppBehaviorScreen.routeName;

  const AppBehaviorScreenWrapper({Key? key}) : super(key: key);

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
