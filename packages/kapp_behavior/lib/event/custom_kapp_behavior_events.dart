import 'kapp_behavior_event.dart';

// TODO:
// Evaluate remove `KAppBehavior` prefix. In case of collision use named imports.

/// Base

abstract class KAppBehaviorUiEvent implements KAppBehaviorEvent {}

abstract class KAppBehaviorBusinessLogicEvent implements KAppBehaviorEvent {}

abstract class KAppBehaviorUseCaseEvent implements KAppBehaviorEvent {}

/// Composed
