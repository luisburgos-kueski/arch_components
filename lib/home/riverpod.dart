import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:merchants_data/merchants_data.dart';

import 'view_data_model.dart';

final merchantsRepositoryProvider = Provider<FakeMerchantsRepository>((ref) {
  final merchants = FakeMerchantsRepository();
  ref.onDispose(() => merchants.dispose());
  return merchants;
});

final merchantListStateChangesProvider =
    StreamProvider.autoDispose<List<MerchantViewData>>((ref) {
  final merchantsRepository = ref.watch(merchantsRepositoryProvider);
  return merchantsRepository
      .merchantListStateChanges()
      .asyncMap<List<MerchantViewData>>(
        (merchantList) => Future.wait(
          (merchantList ?? []).map<Future<MerchantViewData>>(
            (merchant) async => MerchantViewData(
              id: merchant.id,
              name: merchant.name,
            ),
          ),
        ),
      );
});
