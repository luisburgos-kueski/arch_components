import 'package:bloc/bloc.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event is KDefaultAppBehaviorEvent) {
      KAppBehavior.registerEvent(event);
    }
  }
}
