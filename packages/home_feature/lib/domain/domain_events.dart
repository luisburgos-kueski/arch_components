import 'package:kapp_behavior/kapp_behavior.dart';

import '../constants.dart';

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

class ClearingMerchantsList extends HomeUseCaseEvent {
  @override
  final String name = useCaseClearingMerchantsList;

  ClearingMerchantsList() : super();
}

class LoadingMerchantsList extends HomeUseCaseEvent {
  @override
  final String name = useCaseLoadingMerchantsList;

  LoadingMerchantsList() : super();
}

class OnMerchantListCleared extends HomeUseCaseEvent {
  @override
  final String name = useCaseMerchantsListCleared;

  OnMerchantListCleared() : super();
}

class OnMerchantListLoaded extends HomeUseCaseEvent {
  @override
  final String name = useCaseMerchantsListLoaded;

  @override
  Map<String, dynamic>? get params => {
        paramNumberOfMerchantsLoaded: listLength,
      };

  OnMerchantListLoaded({
    required this.listLength,
  }) : super();

  final int listLength;
}
