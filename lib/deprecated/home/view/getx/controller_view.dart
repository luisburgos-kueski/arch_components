import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/components.dart';
import '../../view/view_data_model.dart';
import '../../view/view_template.dart';
import 'controller.dart';

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
          onMerchantItemClicked: (merchantData) {
            //TODO notify: Merchant Item Tapped
            controller.navigateToMerchantDetail(merchantData);
          },
        ),
        failureViewBuilder: () => const Center(
          child: Text('TODO: Handle error'),
        ),
        onLoadMerchantsPressed: () {
          controller.loadMerchants();
        },
        onClearMerchantsPressed: () {
          controller.clearMerchants();
        },
        onSettingsPressed: () {
          controller.navigateToSettings();
        },
      );
    });
  }
}