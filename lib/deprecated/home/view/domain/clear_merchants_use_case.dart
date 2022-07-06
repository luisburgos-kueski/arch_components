import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

class ClearMerchantsUseCase with KAppBehaviorEventNotifier {
  ClearMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<void> run() async {
    await Future.delayed(const Duration(milliseconds: 1900));
    await repository.wipeMerchantsList();

    notifyUseCase(OnMerchantListCleared());
  }
}

class OnMerchantListCleared extends UseCaseKAppBehaviorEvent {
  @override
  final String name = 'on_merchant_list_cleared';

  @override
  final Map<String, dynamic>? params;

  OnMerchantListCleared({this.params});
}
