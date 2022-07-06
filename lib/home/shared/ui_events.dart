import 'package:kapp_behavior/kapp_behavior.dart';

class OnSettingsButtonPressed extends UiKAppBehaviorEvent {
  @override
  final String name = 'settings_button_pressed';

  @override
  final Map<String, dynamic>? params;

  OnSettingsButtonPressed({this.params});
}

class OnLoadMerchantsButtonPressed extends UiKAppBehaviorEvent {
  @override
  final String name = 'load_merchants_button_pressed';

  @override
  final Map<String, dynamic>? params;

  OnLoadMerchantsButtonPressed({this.params});
}

class OnClearMerchantsButtonPressed extends UiKAppBehaviorEvent {
  @override
  final String name = 'clear_merchants_button_pressed';

  @override
  final Map<String, dynamic>? params;

  OnClearMerchantsButtonPressed({this.params});
}
