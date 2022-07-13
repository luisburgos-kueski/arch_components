import 'package:core/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:klog_behavior/klog_behavior.dart';

import 'components.dart';

class MerchantDetailViewTemplate extends StatelessWidget {
  const MerchantDetailViewTemplate({
    Key? key,
    required this.merchantName,
    required this.onBackToHomeTextButtonClicked,
    required this.onBackPressed,
  }) : super(key: key);

  final String merchantName;
  final VoidCallback onBackToHomeTextButtonClicked;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: Text(
          'MerchantDetails ($merchantName)',
        ),
      ),
      onBackPressed: () {
        onBackPressed();
      },
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
                    onBackToHomeTextButtonClicked();
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
