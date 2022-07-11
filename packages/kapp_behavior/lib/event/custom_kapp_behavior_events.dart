import 'kapp_behavior_event.dart';

// TODO:
// Evaluate remove `KAppBehavior` prefix. In case of collision use named imports.

abstract class KAppBehaviorUiEvent implements KAppBehaviorEvent {}

abstract class KAppBehaviorBusinessLogicEvent with KAppBehaviorEvent {}

abstract class KAppBehaviorUseCaseEvent implements KAppBehaviorEvent {}
