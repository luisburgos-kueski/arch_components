import 'kapp_behavior_event.dart';

///TODO: Evaluate duplicated events on Bloc approach.
abstract class UiKAppBehaviorEvent implements KAppBehaviorEvent {}

abstract class BlocKAppBehaviorEvent with KAppBehaviorEvent {}

abstract class UseCaseKAppBehaviorEvent implements KAppBehaviorEvent {}
