import 'package:kapp_behavior/kapp_behavior.dart';

import '../tools/klogger.dart';

class KDefaultAppObserver implements KAppBehaviorEventObserver {
  const KDefaultAppObserver();

  @override
  void onEvent(KAppBehaviorEvent event) {
    KLogger.log(event.toString(), 'APP_BEHAVIOR');
    //TODO: Send to data sources
  }
}
