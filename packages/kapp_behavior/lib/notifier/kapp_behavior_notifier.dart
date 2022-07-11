import '../kapp_behavior.dart';

//TODO: Make notify support methods async operations?
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

abstract class KAppBehaviorBusinessLogicNotifier {
  void notifyBusinessLogicRequest(KAppBehaviorBusinessLogicEvent event) {
    KAppBehavior.notify(event);
  }
}

abstract class KAppBehaviorScreenNotifier {
  void notifyNavigation(KAppBehaviorScreenEvent event) {
    KAppBehavior.notify(event);
  }
}

abstract class KAppBehaviorOnBackPressedNotifier {
  void notifyOnBackPressed({
    required String fromRoute,
    BackSource source = BackSource.system,
  }) {
    KAppBehavior.registerEvent(
      KAppBehaviorOnBackPressedEvent(
        from: fromRoute,
        source: source,
      ),
    );
  }
}

//TODO: Challenge back source items naming
enum BackSource {
  user,
  system,
}

class KAppBehaviorOnBackPressedEvent implements KAppBehaviorUiEvent {
  @override
  String get name => 'on_back_pressed';

  @override
  Map<String, dynamic>? get params => {
        'from_route': from,
        'source': source,
      };

  @override
  final DateTime timestamp;

  final String from;
  final BackSource source;

  KAppBehaviorOnBackPressedEvent({
    required this.from,
    required this.source,
  }) : timestamp = DateTime.now();
}
