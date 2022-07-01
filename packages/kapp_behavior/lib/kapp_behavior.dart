library kapp_behavior;

import 'dart:developer' as dev;

import 'package:core/in_memory_store.dart';

import 'event/kapp_behavior_event.dart';
import 'observer/kapp_behavior_observer.dart';

export 'event/kapp_behavior_event.dart';
export 'notifier/kapp_behavior_notifier.dart';
export 'observer/kapp_behavior_observer.dart';
export 'widget/kroute_aware_screen.dart';

/// TODO: Evaluate use InMemoryStore
/// TODO: Evaluate define AppBehaviorEvent class
/// TODO: Should the API call be made from here?
class KAppBehavior {
  KAppBehavior._();
  static final KAppBehavior _instance = KAppBehavior._();
  factory KAppBehavior() => _instance;

  static void init(
    KAppEventObserver eventObserver,
    KAppRouteObserver routeObserver,
  ) {
    _observer = eventObserver;
    _routeObserver = routeObserver;
  }

  static KAppEventObserver? _observer;
  static KAppRouteObserver? _routeObserver;

  static KAppEventObserver get observer {
    //TODO: App proper exception message for use case.
    if (_observer == null) throw Exception();
    return _observer!;
  }

  static KAppRouteObserver get routeObserver {
    //TODO: App proper exception message for use case.
    if (_routeObserver == null) throw Exception();
    return _routeObserver!;
  }

  final KAppBehaviorInMemoryStore eventsStore = KAppBehaviorInMemoryStore();

  Future<void> registerDefault({
    required String name,
    Map<String, dynamic>? parameters,
  }) {
    return registerEvent(
      KDefaultAppBehaviorEvent.named(name, params: parameters ?? {}),
    );
  }

  Future<void> registerEvent(KAppBehaviorEvent event) async {
    const String kReservedPrefix = 'kapp_behavior_';

    if (event.name.startsWith(kReservedPrefix)) {
      throw ArgumentError.value(
        event.name,
        'name',
        'Prefix "$kReservedPrefix" is reserved and cannot be used.',
      );
    }

    dev.log(
      '[$kReservedPrefix${event.name}, ${DateTime.now()}, ${event.params}]',
    );
    eventsStore.add(event);
    KAppBehavior.observer.onEvent(event);
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
