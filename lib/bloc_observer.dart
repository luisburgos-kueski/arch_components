import 'package:bloc/bloc.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

class BlocToAppBehaviorObserver extends BlocObserver
    with KAppBehaviorBlocNotifier {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event is BlocKAppBehaviorEvent) {
      notifyBusinessLogicRequest(event);
    }
  }
}
