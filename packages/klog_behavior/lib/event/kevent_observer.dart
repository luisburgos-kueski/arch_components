import 'k_event.dart';

abstract class KEventObserver {
  void onEvent(KEvent event);
}
