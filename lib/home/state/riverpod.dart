import 'package:arch_components/home/domain/load_merchants_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:merchants_data/merchants_data.dart';

import '../shared/view_data_model.dart';

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

class HomeScreenRiverpodController extends StateNotifier<AsyncValue<void>> {
  HomeScreenRiverpodController({
    required this.repository,
  }) : super(const AsyncData(null));

  final FakeMerchantsRepository repository;

  Future<void> navigateTo(MerchantViewData data) async {
    final String merchantId = data.id;
    Get.toNamed('/home/$merchantId');
  }

  Future<void> loadMerchants() async {
    state = const AsyncValue.loading();

    /// FIXME:
    ///  Unhandled Exception:
    ///  Bad state: Tried to use HomeScreenRiverpodController after
    ///  `dispose` was called.
    state = await AsyncValue.guard(
      LoadMerchantsUseCase(
        repository: repository,
      ).run,
    );
  }

  Future<void> clearMerchants() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(repository.wipeMerchantsList);
  }
}

final homeScreenControllerProvider = StateNotifierProvider.autoDispose<
    HomeScreenRiverpodController, AsyncValue<void>>((ref) {
  return HomeScreenRiverpodController(
    repository: ref.watch(merchantsRepositoryProvider),
  );
});
