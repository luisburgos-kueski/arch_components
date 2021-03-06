import 'kapp_behavior_event.dart';

// TODO:
// Evaluate remove `KAppBehavior` prefix. In case of collision use named imports.

abstract class KAppBehaviorUiEvent implements KAppBehaviorEvent {}

abstract class KAppBehaviorBusinessLogicEvent implements KAppBehaviorEvent {}

abstract class KAppBehaviorNavigationEvent implements KAppBehaviorEvent {
  @override
  String get name => 'navigate_to';

  String get associatedDomain;
  String get destinationPath;

  @override
  Map<String, dynamic>? get params => {
        'associated_domain': associatedDomain,
        'destination_path': destinationPath,
      };
}

abstract class KAppBehaviorUseCaseEvent implements KAppBehaviorEvent {}

abstract class KAppBehaviorButtonPressed extends KAppBehaviorUiEvent {
  KAppBehaviorButtonPressed() : timestamp = DateTime.now();

  @override
  String get name => 'button_pressed';

  @override
  final DateTime timestamp;

  String get buttonName;

  @override
  Map<String, dynamic>? get params => {
        'button_name': buttonName,
      };
}
