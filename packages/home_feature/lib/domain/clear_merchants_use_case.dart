import 'package:core/core.dart';
import 'package:home_feature/domain/domain_events.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

class ClearMerchantsUseCase extends IUseCaseNoInput
    with KAppBehaviorUseCaseNotifier {
  ClearMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  @override
  Future<void> run() async {
    notifyUseCase(ClearingMerchantsList());
    await Future.delayed(const Duration(milliseconds: 1900));
    await repository.wipeMerchantsList();
    notifyUseCase(OnMerchantListCleared());
  }
}
