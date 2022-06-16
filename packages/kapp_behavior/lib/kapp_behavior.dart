library kapp_behavior;

import 'dart:developer' as dev;

/// TODO: Evaluate use InMemoryStore
/// TODO: Evaluate define AppBehaviorEvent class
/// TODO: Should the API call be made from here?
class KAppBehavior {
  KAppBehavior._();
  static final KAppBehavior _instance = KAppBehavior._();

  factory KAppBehavior() => _instance;

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
