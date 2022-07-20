import 'package:kapp_behavior/kapp_behavior.dart';

import '../constants.dart';

class MerchantTilePressed extends KAppBehaviorListTilePressed {
  MerchantTilePressed({
    required this.merchantName,
  }) : super();

  final String merchantName;

  @override
  String get associatedDomain => domainHome;

  @override
  Map<String, dynamic>? get extraParams => {
        paramMerchantName: merchantName,
      };
}

class AppBehaviorButtonPressed extends KAppBehaviorButtonPressed {
  AppBehaviorButtonPressed() : super();

  @override
  String get associatedDomain => domainHome;

  @override
  final String buttonName = uiAppBehaviorButtonPressed;
}

class LogBehaviorButtonPressed extends KAppBehaviorButtonPressed {
  LogBehaviorButtonPressed() : super();

  @override
  String get associatedDomain => domainHome;

  @override
  final String buttonName = uiLogBehaviorButtonPressed;
}

class LoadMerchantsButtonPressed extends KAppBehaviorButtonPressed {
  LoadMerchantsButtonPressed() : super();

  @override
  String get associatedDomain => domainHome;

  @override
  final String buttonName = uiLoadMerchantsButtonPressed;
}

class ClearMerchantsButtonPressed extends KAppBehaviorButtonPressed {
  ClearMerchantsButtonPressed() : super();

  @override
  String get associatedDomain => domainHome;

  @override
  final String buttonName = uiClearMerchantsButtonPressed;
}
