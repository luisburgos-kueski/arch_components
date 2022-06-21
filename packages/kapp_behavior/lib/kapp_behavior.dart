library kapp_behavior;

import 'dart:developer' as dev;

/// TODO: Evaluate use InMemoryStore
/// TODO: Evaluate define AppBehaviorEvent class
/// TODO: Should the API call be made from here?
class KAppBehavior {
  KAppBehavior._();
  static final KAppBehavior _instance = KAppBehavior._();

  factory KAppBehavior() => _instance;

  Future<void> log(KAppBehaviorEvent event) {
    return logEvent(name: event.name, parameters: event.parameters);
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    const String kReservedPrefix = 'kapp_behavior_';

    if (name.startsWith(kReservedPrefix)) {
      throw ArgumentError.value(name, 'name',
          'Prefix "$kReservedPrefix" is reserved and cannot be used.');
    }

    dev.log('[$kReservedPrefix$name, ${DateTime.now()}, $parameters]');
  }
}

abstract class KAppBehaviorEvent {
  KAppBehaviorEvent({
    required this.name,
    this.parameters,
  });

  KAppBehaviorEvent.named(String aName)
      : name = aName,
        parameters = null;

  final String name;
  final Map<String, Object?>? parameters;
}
