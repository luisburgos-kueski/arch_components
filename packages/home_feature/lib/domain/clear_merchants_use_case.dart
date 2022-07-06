import 'package:home_feature/domain/domain_events.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

class ClearMerchantsUseCase with KAppBehaviorUseCaseNotifier {
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
