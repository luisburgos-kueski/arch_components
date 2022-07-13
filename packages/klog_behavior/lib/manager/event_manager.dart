import '../event/event.dart';

@Deprecated("Use [EventListener]")
abstract class EventManager {
  bool get enabled;
  List<EventProducer> get eventProducers;
  void log(Event event);
}

@Deprecated("Will be removed in v2.0")
abstract class EventProducer {
  void logEvent(Event event);
}
