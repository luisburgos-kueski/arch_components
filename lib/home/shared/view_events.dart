//TODO: Verify overrides. Could this be optional to override?
import 'package:equatable/equatable.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import 'view_data_model.dart';

abstract class HomeEvent extends Equatable implements KDefaultAppBehaviorEvent {
  HomeEvent()
      : timestamp = DateTime.now(),
        super();

  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic>? get params => null;

  @override
  List<Object?> get props => [];
}

class LoadMerchantsPressed extends HomeEvent {
  @override
  String get name => 'load_merchants_pressed';
}

class NavigateToSettingsPressed extends HomeEvent {
  @override
  String get name => 'navigate_to_settings';
}

class ClearMerchantsPressed extends HomeEvent {
  @override
  String get name => 'clear_merchants_pressed';
}

class NavigateToMerchantDetailPressed extends HomeEvent {
  NavigateToMerchantDetailPressed(this.merchantData);

  final MerchantViewData merchantData;

  @override
  String get name => 'navigate_to_merchant_detail';

  @override
  Map<String, dynamic>? get params => {
        'merchant_name': merchantData.name,
        'merchant_id': merchantData.id,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [merchantData];
}
