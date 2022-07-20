import 'package:kapp_behavior/kapp_behavior.dart';

import '../constants.dart';

class BackToHomeTextButtonPressed extends KAppBehaviorBackPressedEvent {
  BackToHomeTextButtonPressed({
    required String fromRoute,
    required BackSource source,
  }) : super(
          from: fromRoute,
          source: source,
          extraParams: {
            'associated_domain': merchantDetailDomain,
          },
        );
}
