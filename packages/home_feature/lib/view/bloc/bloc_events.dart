//TODO: Verify overrides. Could this be optional to override?
import 'package:equatable/equatable.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import '../view_data_model.dart';

abstract class HomeEvent extends Equatable implements BlocKAppBehaviorEvent {
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

class NavigateToSettings extends HomeEvent {
  @override
  String get name => 'navigate_to_settings';
}

class ClearHomeMerchants extends HomeEvent {
  @override
  String get name => 'clear_home_merchants';
}

class NavigateToMerchantDetail extends HomeEvent {
  NavigateToMerchantDetail(this.merchantData);

  final MerchantViewData merchantData;

  @override
  String get name => 'navigate_to_merchant_detail';

  @override
  Map<String, dynamic>? get params => {
        'merchant_name': merchantData.name,
        'merchant_id': merchantData.id,
      };

  @override
  List<Object?> get props => [merchantData];
}
