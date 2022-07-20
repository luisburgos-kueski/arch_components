import 'package:kapp_behavior/kapp_behavior.dart';

import '../constants.dart';

class MerchantTilePressed extends KAppBehaviorListTilePressed {
  MerchantTilePressed({
    required this.merchantName,
  }) : super();

  final String merchantName;

  @override
  String get associatedDomain => 'home_merchants';

  @override
  String get name => 'merchant_tile_pressed';

  @override
  Map<String, dynamic>? get extraParams => {
        'merchant_name': merchantName,
      };
}

class AppBehaviorButtonPressed extends KAppBehaviorButtonPressed {
  AppBehaviorButtonPressed() : super();

  @override
  String get associatedDomain => homeDomain;

  @override
  final String buttonName = 'app_behavior_button_pressed';
}

class LogBehaviorButtonPressed extends KAppBehaviorButtonPressed {
  LogBehaviorButtonPressed() : super();

  @override
  String get associatedDomain => homeDomain;

  @override
  final String buttonName = 'log_behavior_button_pressed';
}

class LoadMerchantsButtonPressed extends KAppBehaviorButtonPressed {
  LoadMerchantsButtonPressed() : super();

  @override
  String get associatedDomain => homeDomain;

  @override
  final String buttonName = 'load_merchants_button_pressed';
}

class ClearMerchantsButtonPressed extends KAppBehaviorButtonPressed {
  ClearMerchantsButtonPressed() : super();

  @override
  String get associatedDomain => homeDomain;

  @override
  final String buttonName = 'clear_merchants_button_pressed';
}
