import 'package:arch_components/helpers/kapp_behavior_list_view.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import '../tools/klogger.dart';

class KDefaultAppObserver implements KAppBehaviorEventObserver {
  const KDefaultAppObserver();

  @override
  void onEvent(KAppBehaviorEvent event) {
    AppBehaviorScreen.eventsStore.add(event);
    KLogger.log(event.toString(), 'APP_BEHAVIOR');
    //TODO: Send to data sources
  }
}
