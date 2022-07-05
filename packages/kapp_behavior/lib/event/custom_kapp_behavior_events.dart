import 'kapp_behavior_event.dart';

///TODO: Evaluate duplicated events on Bloc approach.
abstract class UiKAppBehaviorEvent implements KDefaultAppBehaviorEvent {
  @override
  DateTime get timestamp => DateTime.now();

  @override
  Map<String, dynamic>? get params => null;
}

abstract class BlocKAppBehaviorEvent with KAppBehaviorEvent {
  @override
  final DateTime timestamp;

  BlocKAppBehaviorEvent() : timestamp = DateTime.now();
}

abstract class UseCaseKAppBehaviorEvent implements KDefaultAppBehaviorEvent {
  @override
  final DateTime timestamp;

  UseCaseKAppBehaviorEvent() : timestamp = DateTime.now();
}
