import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import 'components.dart';

class MerchantDetailViewTemplate extends StatelessWidget {
  const MerchantDetailViewTemplate({
    Key? key,
    required this.merchantName,
    required this.onBackButtonPressed,
  }) : super(key: key);

  final String merchantName;
  final Function() onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                onBackClicked: onBackButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
