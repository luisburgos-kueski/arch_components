import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/bloc/bloc_view.dart';

class MerchantDetailScreen extends StatelessWidget {
  static String routeName = '/home/:id';

  const MerchantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Validate best way to pass data to named routes
    final merchantName = Get.parameters['id'] as String;
    if (TempStaticFeatureToggles.useBloc) {
      return MerchantDetailBlocView(
        merchantName: merchantName,
      );
    }

    // TODO: implement riverpod and getx variants
    return const Scaffold();
  }
}
