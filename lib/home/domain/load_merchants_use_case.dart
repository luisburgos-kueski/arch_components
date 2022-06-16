import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

class LoadMerchantsUseCase {
  LoadMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<List<Merchant>> run() async {
    await Future.delayed(const Duration(milliseconds: 1900));
    await repository.loadMerchantsList();
    final list = repository.currentMerchantList ?? [];

    await KAppBehavior().logEvent(
      name: 'on_merchant_list_loaded',
      parameters: {
        'list_length': list.length,
      },
    );

    return list;
  }
}
