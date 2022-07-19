import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

import '../../domain/clear_merchants_use_case.dart';
import '../../domain/load_merchants_use_case.dart';
import '../../redirections.dart';
import '../bloc/bloc_events.dart';
import '../view_data_model.dart';

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
    with KAppBehaviorBusinessLogicNotifier {
  HomeScreenRiverpodController({
    required this.repository,
  }) : super(const AsyncData(null));

  late HomeRedirections redirections;
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
    notifyBusinessLogicRequest(NavigateToMerchantDetail(
      data,
      redirections.merchantDetailPath,
    ));

    final String merchantId = data.id;
    redirections.goToMerchantDetail(merchantId);
  }

  Future<void> navigateToSettings() async {
    notifyBusinessLogicRequest(NavigateToAppBehavior(
      redirections.appBehaviorPath,
    ));
    redirections.goToSettings();
  }

  Future<void> displayClearActionInstructions(Function() displayView) async {
    notifyBusinessLogicRequest(DisplayClearActionInstructions(displayView));
  }
}

final homeScreenControllerProvider = StateNotifierProvider.autoDispose<
    HomeScreenRiverpodController, AsyncValue<void>>((ref) {
  return HomeScreenRiverpodController(
    repository: ref.watch(merchantsRepositoryProvider),
  );
});
