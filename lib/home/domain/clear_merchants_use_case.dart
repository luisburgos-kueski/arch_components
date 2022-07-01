import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

class ClearMerchantsUseCase {
  ClearMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<void> run() async {
    await Future.delayed(const Duration(milliseconds: 1900));
    await repository.wipeMerchantsList();

    await KAppBehavior().registerDefault(
      name: 'on_merchant_list_cleared',
    );
  }
}
