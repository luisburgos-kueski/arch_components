import 'package:kapp_behavior/event/custom_kapp_behavior_events.dart';

abstract class HomeUiEvent implements KAppBehaviorUiEvent {
  @override
  final DateTime timestamp;

  HomeUiEvent() : timestamp = DateTime.now();
}

class MerchantTilePressed extends HomeUiEvent {
  MerchantTilePressed({
    required this.merchantName,
  }) : super();

  @override
  String get name => 'merchant_tile_pressed';

  @override
  Map<String, dynamic>? get params => {
        'merchant_name': merchantName,
      };

  final String merchantName;
}

class AppBehaviorButtonPressed extends KAppBehaviorButtonPressed {
  AppBehaviorButtonPressed() : super();

  @override
  final String buttonName = 'app_behavior_button_pressed';
}

class LogBehaviorButtonPressed extends KAppBehaviorButtonPressed {
  LogBehaviorButtonPressed() : super();

  @override
  final String buttonName = 'log_behavior_button_pressed';
}

class LoadMerchantsButtonPressed extends KAppBehaviorButtonPressed {
  LoadMerchantsButtonPressed() : super();

  @override
  final String buttonName = 'load_merchants_button_pressed';
}

class ClearMerchantsButtonPressed extends KAppBehaviorButtonPressed {
  ClearMerchantsButtonPressed() : super();

  @override
  final String buttonName = 'clear_merchants_button_pressed';
}
