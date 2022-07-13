import 'dart:developer' as developer;

import '../event/event.dart';
import 'event_manager.dart';

@Deprecated("Will be removed in v2.0")
class InternalBehaviorEventProducer implements EventProducer {
  static InternalBehaviorEventProducer? _instance;

  InternalBehaviorEventProducer._internal();

  factory InternalBehaviorEventProducer() {
    _instance ??= InternalBehaviorEventProducer._internal();
    return _instance!;
  }

  @override
  void logEvent(Event event) {
    /// Data Source API should be able to process the event and based on
    /// the event data send it to the correct data store
    developer.log("InternalBehavior: ${event.format()}");
  }
}

@Deprecated("Will be removed in v2.0")
class FirebaseAppBehaviorEventProducer implements EventProducer {
  static FirebaseAppBehaviorEventProducer? _instance;

  FirebaseAppBehaviorEventProducer._internal();

  factory FirebaseAppBehaviorEventProducer() {
    _instance ??= FirebaseAppBehaviorEventProducer._internal();
    return _instance!;
  }

  @override
  void logEvent(Event event) {
    /// Filter events to be sent to firebase
    /// We should only send app behavior events to firebase
    if (event.source == Source.appBehavior) {
      // Send event to firebase
      developer.log("FirebaseAppBehavior: ${event.format()}");
    }
  }
}

@Deprecated("Will be removed in v2.0")
class DefaultEventManager implements EventManager {
  final bool _enabled;

  DefaultEventManager({
    bool enabled = true,
  }) : _enabled = enabled;

  @override
  void log(Event event) {
    if (enabled) {
      for (EventProducer producer in eventProducers) {
        producer.logEvent(event);
      }
    }
  }

  @override
  List<EventProducer> get eventProducers => [
        InternalBehaviorEventProducer(),
        FirebaseAppBehaviorEventProducer(),
      ];

  @override
  bool get enabled => _enabled;
}
