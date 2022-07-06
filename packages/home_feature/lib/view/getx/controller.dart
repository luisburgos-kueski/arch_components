import 'package:get/get.dart';
import 'package:home_feature/domain/clear_merchants_use_case.dart';
import 'package:home_feature/domain/load_merchants_use_case.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_repository.dart';

import '../../domain/clear_merchants_use_case.dart';
import '../../domain/load_merchants_use_case.dart';
import '../view_data_model.dart';

class HomeController extends GetxController {
  RxList<MerchantViewData> merchantData = RxList();
  Rx<HomeStatus> status = HomeStatus.initial.obs;

  Future<void> loadMerchants() async {
    status(HomeStatus.loading);

    final result = await LoadMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    status(HomeStatus.success);
    merchantData.clear();
    merchantData.addAll(MerchantViewData.listFrom(result));
  }

  Future<void> clearMerchants() async {
    status(HomeStatus.loading);

    await ClearMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    status(HomeStatus.success);
    merchantData.clear();
  }

  Future<void> navigateToMerchantDetail(MerchantViewData data) async {
    final String merchantId = data.id;
    Get.toNamed('/home/$merchantId');
  }

  Future<void> navigateToSettings() async {
    //TODO: Remove dependency with AppBehavior
    Get.toNamed(AppBehaviorScreen.routeName);
  }
}
