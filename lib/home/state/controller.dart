import 'package:arch_components/home/domain/load_merchants_use_case.dart';
import 'package:get/get.dart';
import 'package:merchants_data/merchants_repository.dart';

import '../shared/view_data_model.dart';

class HomeController extends GetxController {
  RxList<MerchantViewData> merchantData = RxList();
  Rx<HomeStatus> status = HomeStatus.initial.obs;

  Future<void> onLoadMerchantsEvent() async {
    status(HomeStatus.loading);

    final result = await LoadMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    status(HomeStatus.success);
    merchantData.clear();
    merchantData.addAll(MerchantViewData.listFrom(result));
  }

  Future<void> onClearMerchantsEvent() async {
    status(HomeStatus.loading);

    /// TODO: Call repository or use case
    await Future.delayed(const Duration(milliseconds: 1500));

    status(HomeStatus.success);
    merchantData.clear();
  }

  Future<void> onNavigateToMerchantDetailEvent(MerchantViewData data) async {
    final String merchantId = data.id;

    Get.toNamed('/home/$merchantId');
  }
}
