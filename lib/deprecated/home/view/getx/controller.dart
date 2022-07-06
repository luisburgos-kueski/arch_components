import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_repository.dart';

import '../../domain/clear_merchants_use_case.dart';
import '../../domain/load_merchants_use_case.dart';
import '../../view/view_data_model.dart';
import '../bloc/bloc_events.dart';

class HomeController extends GetxController with KAppBehaviorEventNotifier {
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
    notifyBusinessLogicRequest(NavigateToMerchantDetail(data));

    final String merchantId = data.id;
    Get.toNamed('/home/$merchantId');
  }

  Future<void> navigateToSettings() async {
    notifyBusinessLogicRequest(NavigateToSettings());
    Get.toNamed(AppBehaviorScreen.routeName);
  }
}
