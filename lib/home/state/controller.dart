import 'package:arch_components/home/domain/clear_merchants_use_case.dart';
import 'package:arch_components/home/domain/load_merchants_use_case.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_repository.dart';

import '../shared/view_data_model.dart';
import '../shared/view_events.dart';

class HomeController extends GetxController with KAppBehaviorEventNotifier {
  RxList<MerchantViewData> merchantData = RxList();
  Rx<HomeStatus> status = HomeStatus.initial.obs;

  Future<void> onLoadMerchantsEvent() async {
    notify(LoadMerchantsPressed());

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

    await ClearMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    status(HomeStatus.success);
    merchantData.clear();
  }

  Future<void> onNavigateToMerchantDetailEvent(MerchantViewData data) async {
    final String merchantId = data.id;

    Get.toNamed('/home/$merchantId');
  }
}
