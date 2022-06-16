import 'package:get/get.dart';

import '../shared/view_data_model.dart';

class HomeController extends GetxController {
  RxList<MerchantViewData> merchantData = RxList();
  Rx<HomeStatus> status = HomeStatus.initial.obs;

  Future<void> onLoadMerchantsEvent() async {
    status(HomeStatus.loading);

    /// TODO: Call repository or use case
    await Future.delayed(const Duration(milliseconds: 2100));

    status(HomeStatus.success);
    merchantData.addAll(
      [
        const MerchantViewData(id: 'xiaomi', name: 'Xiaomi'),
        const MerchantViewData(id: 'doto', name: 'Tío Doto'),
        const MerchantViewData(id: 'meibi', name: 'Meibi'),
        const MerchantViewData(id: 'gaia', name: 'GAIA Design'),
      ],
    );
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
