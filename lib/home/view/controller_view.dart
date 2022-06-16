import 'package:arch_components/home/state/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/view_data_model.dart';
import '../shared/view_template.dart';
import 'components.dart';

class HomeControllerView extends StatelessWidget {
  const HomeControllerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Obx(() {
      return HomeViewTemplate(
        tag: 'getx',
        isLoading: controller.status() == HomeStatus.loading,
        displayFailure: controller.status() == HomeStatus.failure,
        merchantsList: MerchantsList(
          items: controller.merchantData(),
          onGoToMerchantDetail: (merchantData) {
            controller.onNavigateToMerchantDetailEvent(merchantData);
          },
        ),
        failureViewBuilder: () => const Center(
          child: Text('TODO: Handle error'),
        ),
        onLoadMerchantsPressed: () {
          controller.onLoadMerchantsEvent();
        },
        onClearMerchantsPressed: () {
          controller.onClearMerchantsEvent();
        },
      );
    });
  }
}
