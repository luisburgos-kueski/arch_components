import 'dart:developer';

import '../kapp_behavior.dart';

abstract class KAppBehaviorEventNotifier {
  void notifyUi(UiKAppBehaviorEvent event) {
    _notifyAppBehavior(event);
  }

  void notifyUseCase(UseCaseKAppBehaviorEvent event) {
    _notifyAppBehavior(event);
  }

  void notifyBusinessLogicRequest(BlocKAppBehaviorEvent event) {
    _notifyAppBehavior(event);
  }

  void notifyNavigation(KScreenEvent event) {
    _notifyAppBehavior(event);
  }

  void _notifyAppBehavior(KAppBehaviorEvent event) {
    log(
      '$runtimeType - $event',
      name: 'APP_BEHAVIOR',
    );
    KAppBehavior.registerEvent(event);
  }
}
