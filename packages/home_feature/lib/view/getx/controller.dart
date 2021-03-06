import 'package:get/get.dart';
import 'package:home_feature/domain/clear_merchants_use_case.dart';
import 'package:home_feature/domain/load_merchants_use_case.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_repository.dart';

import '../../domain/clear_merchants_use_case.dart';
import '../../domain/load_merchants_use_case.dart';
import '../../redirections.dart';
import '../bloc/bloc_events.dart';
import '../view_data_model.dart';

/// TODO:
/// Research if onEvent method could be override to intercept Navigation events.
///
/// By using [KAppBehaviorBusinessLogicNotifier] class and calling the
/// [KAppBehaviorBusinessLogicNotifier.notifyBusinessLogicRequest] our `bloc` can log
/// [KAppBehaviorBusinessLogicEvent]s.
class HomeController extends GetxController
    with KAppBehaviorBusinessLogicNotifier {
  HomeController(this.redirections);

  final HomeRedirections redirections;

  RxList<MerchantViewData> merchantData = RxList();
  Rx<HomeStatus> status = HomeStatus.initial.obs;

  Future<void> loadMerchants() async {
    notifyBusinessLogicRequest(LoadHomeMerchants());

    status(HomeStatus.loading);

    final result = await LoadMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    status(HomeStatus.success);
    merchantData.clear();
    merchantData.addAll(MerchantViewData.listFrom(result));
  }

  Future<void> clearMerchants() async {
    notifyBusinessLogicRequest(ClearHomeMerchants());

    status(HomeStatus.loading);

    await ClearMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    status(HomeStatus.success);
    merchantData.clear();
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
