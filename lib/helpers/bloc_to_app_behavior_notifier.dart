import 'package:bloc/bloc.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

/// By using the [KAppBehaviorBusinessLogicNotifier] class and calling the
/// [KAppBehaviorBusinessLogicNotifier.notifyBusinessLogicRequest] our `bloc` are
/// interpreted as [KAppBehaviorBusinessLogicEvent] when using the contract.
class BlocToAppBehaviorEventNotifier extends BlocObserver
    with KAppBehaviorBusinessLogicNotifier {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event is KAppBehaviorBusinessLogicEvent) {
      notifyBusinessLogicRequest(event);
    }
  }
}
