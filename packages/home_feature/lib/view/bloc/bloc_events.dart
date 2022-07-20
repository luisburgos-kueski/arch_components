//TODO: Verify overrides. Could this be optional to override?
import 'package:kapp_behavior/kapp_behavior.dart';

import '../../constants.dart';
import '../view_data_model.dart';

abstract class HomeBlocEvent
    with KTimeMixin
    implements KAppBehaviorBusinessLogicEvent {
  @override
  Map<String, dynamic>? get params => null;
}

class LoadHomeMerchants extends HomeBlocEvent {
  @override
  String get name => loadHomeMerchants;
}

class ClearHomeMerchants extends HomeBlocEvent {
  @override
  String get name => clearHomeMerchants;
}

class ShowClearActionInstructions extends HomeBlocEvent {
  @override
  String get name => showClearActionInstructions;

  ShowClearActionInstructions(this.show);

  final Function() show;
}

class NavigateToAppBehavior extends KAppBehaviorNavigationEvent
    implements HomeBlocEvent {
  NavigateToAppBehavior(this.path) : super();

  final String path;

  @override
  String get destinationPath => path;

  @override
  String get associatedDomain => domainAppBehavior;
}

class NavigateToLogBehavior extends KAppBehaviorNavigationEvent
    implements HomeBlocEvent {
  NavigateToLogBehavior(this.path) : super();

  final String path;

  @override
  String get destinationPath => path;

  @override
  String get associatedDomain => domainLogBehavior;
}

class NavigateToMerchantDetails extends KAppBehaviorNavigationEvent
    implements HomeBlocEvent {
  NavigateToMerchantDetails(
    this.merchantData,
    this.path,
  ) : super();

  final MerchantViewData merchantData;
  final String path;

  @override
  String get destinationPath => path;

  @override
  String get associatedDomain => domainMerchantDetails;

  @override
  Map<String, dynamic>? get params => {
        paramMerchantName: merchantData.name,
        paramMerchantId: merchantData.id,
      };

  /** TODO: Cannot extend from Equatable and NavigateToEvent
  @override
  List<Object?> get props => [merchantData];**/
}
