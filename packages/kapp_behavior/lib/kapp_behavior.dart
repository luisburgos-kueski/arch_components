library kapp_behavior;

import 'package:core/in_memory_store.dart';

import 'event/kapp_behavior_event.dart';
import 'observer/kapp_behavior_observer.dart';

export 'package:kapp_behavior/event/custom_kapp_behavior_events.dart';

export 'event/kapp_behavior_event.dart';
export 'kapp_behavior_list_view.dart';
export 'notifier/kapp_behavior_notifier.dart';
export 'observer/kapp_behavior_observer.dart';
export 'widget/kroute_aware_screen.dart';

/// TODO: Evaluate use InMemoryStore
/// TODO: Evaluate define AppBehaviorEvent class
/// TODO: Should the API call be made from here?
///
/// KAppBehavior.observer.onEvent();
/// KAppBehavior.registerEvent(...);
class KAppBehavior {
  static void init({
    required KAppBehaviorEventObserver eventObserver,
    KAppBehaviorRouteToScreenObserver? routeObserver,
  }) {
    _observer = eventObserver;
    _routeObserver = routeObserver ?? KAppBehaviorRouteToScreenObserver();
  }

  static KAppBehaviorEventObserver? _observer;
  static KAppBehaviorRouteToScreenObserver? _routeObserver;

  //TODO: Challenge being public
  static KAppBehaviorEventObserver get observer {
    //TODO: App proper exception message for use case.
    if (_observer == null) throw Exception();
    return _observer!;
  }

  //TODO: Challenge being public
  static KAppBehaviorRouteToScreenObserver get routeObserver {
    //TODO: App proper exception message for use case.
    if (_routeObserver == null) throw Exception();
    return _routeObserver!;
  }

  static KAppBehaviorInMemoryStore eventsStore = KAppBehaviorInMemoryStore();

  static Future<void> registerDefault({
    required String name,
    Map<String, dynamic>? parameters,
  }) {
    return registerEvent(
      KAppBehaviorDefaultEvent(name, params: parameters ?? {}),
    );
  }

  static Future<void> registerEvent(KAppBehaviorEvent event) async {
    ///TODO: Evaluate remove reserved prefix. Legacy clone from Firebase events.
    const String kReservedPrefix = 'kapp_behavior_';

    if (event.name.startsWith(kReservedPrefix)) {
      throw ArgumentError.value(
        event.name,
        'name',
        'Prefix "$kReservedPrefix" is reserved and cannot be used.',
      );
    }
    observer.onEvent(event);
    KAppBehavior.eventsStore.add(event);
  }

  static void notify(KAppBehaviorEvent event) {
    // log('$event', name: 'APP_BEHAVIOR');
    KAppBehavior.registerEvent(event);
  }
}

class KAppBehaviorInMemoryStore {
  final _state = InMemoryStore<List<KAppBehaviorEvent>>([]);

  Stream<List<KAppBehaviorEvent>> listStateChanges() => _state.stream;

  List<KAppBehaviorEvent> get currentList => _state.value;

  Future<void> loadList() async {
    //TODO: Implement loading items from a local file or a remote.
  }

  Future<void> wipeList() async {
    _state.value = [];
  }

  void dispose() => _state.close();

  void add(KAppBehaviorEvent event) {
    ///TODO: Add async call to send data to remote.
    _state.value.add(event);
  }
}
