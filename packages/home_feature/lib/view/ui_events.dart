import 'package:kapp_behavior/event/custom_kapp_behavior_events.dart';

abstract class HomeUiEvent implements UiKAppBehaviorEvent {
  @override
  final DateTime timestamp;

  HomeUiEvent() : timestamp = DateTime.now();
}

class OnMerchantItemPressed extends HomeUiEvent {
  @override
  String get name => 'merchant_item_tile_${merchantName}_pressed';

  @override
  Map<String, dynamic>? get params => {
        'merchant_name': merchantName,
      };

  OnMerchantItemPressed({
    required this.merchantName,
  }) : super();

  final String merchantName;
}

class OnSettingsButtonPressed extends HomeUiEvent {
  @override
  final String name = 'settings_button_pressed';

  @override
  final Map<String, dynamic>? params;

  OnSettingsButtonPressed({this.params}) : super();
}

class OnLoadMerchantsButtonPressed extends HomeUiEvent {
  @override
  final String name = 'load_merchants_button_pressed';

  @override
  final Map<String, dynamic>? params;

  OnLoadMerchantsButtonPressed({this.params}) : super();
}

class OnClearMerchantsButtonPressed extends HomeUiEvent {
  @override
  final String name = 'clear_merchants_button_pressed';

  @override
  final Map<String, dynamic>? params;

  OnClearMerchantsButtonPressed({this.params}) : super();
}
