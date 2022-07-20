import 'package:kapp_behavior/kapp_behavior.dart';

abstract class MerchantDetailEvent implements KAppBehaviorBusinessLogicEvent {
  MerchantDetailEvent() : timestamp = DateTime.now();

  @override
  final DateTime timestamp;
}

class CloseMerchantDetail extends MerchantDetailEvent {
  CloseMerchantDetail() : super();

  @override
  String get name => 'close_merchant_detail';

  @override
  Map<String, dynamic>? get params => null;
}
