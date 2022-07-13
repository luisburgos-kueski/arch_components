import 'package:flutter/material.dart';
import 'package:klog_behavior/kapp_behavior_ui.dart';

class LogBehaviorScreenWrapper extends StatelessWidget {
  static String get routeName => LogBehaviorScreen.routeName;

  const LogBehaviorScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LogBehaviorScreen(
      onBackPressed: () {
        /*notifyOnBackPressed(
          fromRoute: Get.currentRoute,
        );*/
      },
    );
  }
}
