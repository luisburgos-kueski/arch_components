import 'package:kapp_behavior/kapp_behavior.dart';

class OnBackToHomeTextButtonPressed implements KAppBehaviorUiEvent {
  OnBackToHomeTextButtonPressed({
    this.params,
  }) : timestamp = DateTime.now();

  @override
  String get name => 'on_back_to_home_button_pressed';

  @override
  Map<String, dynamic>? params;

  @override
  DateTime timestamp;
}
