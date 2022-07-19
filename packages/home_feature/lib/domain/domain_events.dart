import 'package:kapp_behavior/kapp_behavior.dart';

abstract class HomeUseCaseEvent implements KAppBehaviorUseCaseEvent {
  HomeUseCaseEvent()
      : timestamp = DateTime.now(),
        super();

  @override
  String get name;

  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic>? get params => null;
}

class OnMerchantListCleared extends HomeUseCaseEvent {
  @override
  final String name = 'merchant_list_cleared';

  OnMerchantListCleared() : super();
}

class OnMerchantListLoaded extends HomeUseCaseEvent {
  @override
  final String name = 'merchant_list_loaded';

  @override
  Map<String, dynamic>? get params => {
        'list_length': listLength,
      };

  OnMerchantListLoaded({
    required this.listLength,
  }) : super();

  final int listLength;
}
