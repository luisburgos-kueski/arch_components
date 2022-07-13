import 'package:core/core.dart';

import 'event/k_event.dart';
import 'event/kevent_observer.dart';
import 'event/navigation/kroute_observer.dart';
import 'utils/constants.dart';

class ObserverFacade {
  final KRouteObserver routeObserver;
  final KEventObserver eventObserver;

  ObserverFacade({
    required this.routeObserver,
    required this.eventObserver,
  });
}

abstract class KLogBehavior {
  static ObserverFacade? _config;

  static void init({required ObserverFacade observerFacade}) {
    _config = observerFacade;
  }

  static KLogBehaviorInMemoryStore eventsStore = KLogBehaviorInMemoryStore();

  static KEventObserver get eventObserver {
    if (_config != null) {
      return _config!.eventObserver;
    }
    throw Exception(initErrorMessage);
  }

  static KRouteObserver get routeObserver {
    if (_config != null) {
      return _config!.routeObserver;
    }
    throw Exception(initErrorMessage);
  }
}

class KLogBehaviorInMemoryStore {
  final _state = InMemoryStore<List<KEvent>>([]);

  Stream<List<KEvent>> listStateChanges() => _state.stream;

  List<KEvent> get currentList => _state.value;

  Future<void> loadList() async {
    //TODO: Implement loading items from a local file or a remote.
  }

  Future<void> wipeList() async {
    _state.value = [];
  }

  void dispose() => _state.close();

  void add(KEvent event) {
    ///TODO: Add async call to send data to remote.
    _state.value.add(event);
  }
}
