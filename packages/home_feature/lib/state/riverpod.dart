import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

import '../domain/clear_merchants_use_case.dart';
import '../domain/load_merchants_use_case.dart';
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
        (merchantList) => MerchantViewData.listFrom(merchantList ?? []),
      );
});

class HomeScreenRiverpodController extends StateNotifier<AsyncValue<void>>
    with KAppBehaviorEventNotifier {
  HomeScreenRiverpodController({
    required this.repository,
  }) : super(const AsyncData(null));

  final FakeMerchantsRepository repository;

  Future<void> loadMerchants() async {
    state = const AsyncValue<void>.loading();

    /// FIXME:
    ///  Unhandled Exception:
    ///  Bad state: Tried to use HomeScreenRiverpodController after
    ///  `dispose` was called.
    await LoadMerchantsUseCase(
      repository: repository,
    ).run();

    state = const AsyncValue<void>.data(null);
  }

  Future<void> clearMerchants() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      ClearMerchantsUseCase(
        repository: repository,
      ).run,
    );
  }

  Future<void> navigateToMerchantDetail(MerchantViewData data) async {
    final String merchantId = data.id;
    Get.toNamed('/home/$merchantId');
  }

  Future<void> navigateToSettings() async {
    Get.toNamed(AppBehaviorScreen.routeName);
  }
}

final homeScreenControllerProvider = StateNotifierProvider.autoDispose<
    HomeScreenRiverpodController, AsyncValue<void>>((ref) {
  return HomeScreenRiverpodController(
    repository: ref.watch(merchantsRepositoryProvider),
  );
});
