//TODO: Verify overrides. Could this be optional to override?
import 'package:equatable/equatable.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import '../view_data_model.dart';

abstract class HomeEvent extends Equatable
    implements KAppBehaviorBusinessLogicEvent {
  HomeEvent()
      : timestamp = DateTime.now(),
        super();

  @override
  String get name;

  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic>? get params => null;

  @override
  List<Object?> get props => [];
}

class LoadHomeMerchants extends HomeEvent {
  @override
  String get name => 'load_home_merchants';
}

class ClearHomeMerchants extends HomeEvent {
  @override
  String get name => 'clear_home_merchants';
}

class DisplayClearActionInstructions extends HomeEvent {
  @override
  String get name => 'display_clear_action_instructions';

  DisplayClearActionInstructions(this.displayView);

  final Function() displayView;
}

class NavigateToAppBehavior extends HomeEvent with KAppBehaviorNavigationEvent {
  NavigateToAppBehavior(this.path) : super();

  final String path;

  @override
  String get destinationPath => path;

  @override
  String get associatedDomain => 'app_behavior';
}

class NavigateToLogBehavior extends HomeEvent with KAppBehaviorNavigationEvent {
  NavigateToLogBehavior(this.path) : super();

  final String path;

  @override
  String get destinationPath => path;

  @override
  String get associatedDomain => 'log_behavior';
}

class NavigateToMerchantDetail extends HomeEvent
    with KAppBehaviorNavigationEvent {
  NavigateToMerchantDetail(
    this.merchantData,
    this.path,
  ) : super();

  final MerchantViewData merchantData;
  final String path;

  @override
  String get destinationPath => path;

  @override
  String get associatedDomain => 'merchant_detail';

  @override
  Map<String, dynamic>? get params => {
        'merchant_name': merchantData.name,
        'merchant_id': merchantData.id,
      };

  /** TODO: Cannot extend from Equatable and NavigateToEvent
  @override
  List<Object?> get props => [merchantData];**/
}
