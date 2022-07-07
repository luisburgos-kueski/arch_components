import 'package:home_feature/domain/domain_events.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

/// By using the [KAppBehaviorUseCaseNotifier] class and calling the
/// [KAppBehaviorUseCaseNotifier.notifyUseCase] our `UseCase` can log
/// [UseCaseKAppBehaviorEvent]s.
class LoadMerchantsUseCase with KAppBehaviorUseCaseNotifier {
  LoadMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<List<Merchant>> run() async {
    return Future.delayed(const Duration(milliseconds: 2900), () async {
      await repository.loadMerchantsList();
      final list = repository.currentMerchantList ?? [];

      notifyUseCase(
        OnMerchantListLoaded(listLength: list.length),
      );

      return list;
    });
  }
}
