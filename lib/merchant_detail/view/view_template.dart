import 'package:core/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import 'components.dart';

@Deprecated('Use MerchantDetailScreen from merchant_detail_feature')
class MerchantDetailViewTemplate extends StatelessWidget
    with KAppBehaviorOnBackPressedNotifier {
  const MerchantDetailViewTemplate({
    Key? key,
    required this.merchantName,
    required this.onBackButtonPressed,
  }) : super(key: key);

  final String merchantName;
  final Function() onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
          title: Text(
        'MerchantDetails ($merchantName)',
      )),
      onBackPressed: () => notifyOnBackPressed(
        fromRoute: Get.currentRoute,
      ),
      body: SafeArea(
        child: NavigationNotifier(
          key: const Key('merchant_detail_screen'),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(merchantName),
                BackToHomeTextButton(
                  onBackClicked: () {
                    notifyOnBackPressed(
                      fromRoute: Get.currentRoute,
                      source: BackSource.user,
                    );
                    onBackButtonPressed();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
