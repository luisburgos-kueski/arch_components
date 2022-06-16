import 'package:arch_components/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components.dart';
import 'view_data_model.dart';
import 'view_template.dart';

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
