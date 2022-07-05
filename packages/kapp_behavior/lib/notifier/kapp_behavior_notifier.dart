import 'dart:developer';

import '../kapp_behavior.dart';

//TODO: Use same approach of OnBackPressedAppBehaviorNotifier
//TODO: Make notify support methods async operations??
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

class OnBackPressedAppBehaviorNotifier {
  void notifyOnBackPressed({
    required String fromRoute,
    BackSource source = BackSource.system,
  }) {
    KAppBehavior.registerEvent(
      CustomNavigateBackAppBehaviorEvent(
        from: fromRoute,
        source: source,
      ),
    );
  }
}

enum BackSource {
  user,
  system,
}

class CustomNavigateBackAppBehaviorEvent implements KDefaultAppBehaviorEvent {
  @override
  String get name => 'custom_navigate_back';

  @override
  Map<String, dynamic>? get params => {
        'from_route': from,
        'source': source,
      };

  @override
  final DateTime timestamp;

  final String from;
  final BackSource source;

  CustomNavigateBackAppBehaviorEvent({
    required this.from,
    required this.source,
  }) : timestamp = DateTime.now();
}
