import '../kapp_behavior.dart';

//TODO: Use same approach of OnBackPressedAppBehaviorNotifier
//TODO: Make notify support methods async operations??
//TODO: Rename to KAppBehaviorNotifier
abstract class KAppBehaviorUiNotifier {
  void notifyUi(KAppBehaviorUiEvent event) {
    KAppBehavior.notify(event);
  }
}

abstract class KAppBehaviorUseCaseNotifier {
  //TODO: UseCase result
  void notifyUseCase(KAppBehaviorUseCaseEvent event) {
    KAppBehavior.notify(event);
  }
}

abstract class KAppBehaviorBlocNotifier {
  void notifyBusinessLogicRequest(KAppBehaviorBusinessLogicEvent event) {
    KAppBehavior.notify(event);
  }
}

abstract class KAppBehaviorScreenNotifier {
  void notifyNavigation(KScreenEvent event) {
    KAppBehavior.notify(event);
  }
}

abstract class OnBackPressedAppBehaviorNotifier {
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

class CustomNavigateBackAppBehaviorEvent implements KAppBehaviorUiEvent {
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
