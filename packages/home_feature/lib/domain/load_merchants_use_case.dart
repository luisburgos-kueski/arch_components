import 'package:merchants_data/merchants_data.dart';

class LoadMerchantsUseCase {
  LoadMerchantsUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<List<Merchant>> run() async {
    return Future.delayed(const Duration(milliseconds: 2900), () async {
      await repository.loadMerchantsList();
      final list = repository.currentMerchantList ?? [];
      return list;
    });
  }
}
