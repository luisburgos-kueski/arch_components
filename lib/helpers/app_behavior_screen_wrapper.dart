//TODO: Evaluate move to own folder.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:klog_behavior/klog_behavior.dart';

class AppBehaviorScreenWrapper extends StatelessWidget
    with KAppBehaviorOnBackPressedNotifier {
  static String get routeName => AppBehaviorScreen.routeName;

  const AppBehaviorScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBehaviorScreen(
      backButtonWidget: UiEventNotifier(
        key: const Key('app_behavior_back_button'),
        builder: (widgetId, publisher) => BackButton(
          onPressed: () {
            publisher.publishUiEvent(OnClicked(widgetId: widgetId));
            //TODO: Logic taken from BackButton. Change to Redirection call?
            Navigator.maybePop(context);
          },
        ),
      ),
      onBackPressed: () {
        notifyOnBackPressed(
          fromRoute: Get.currentRoute,
        );
      },
    );
  }
}
