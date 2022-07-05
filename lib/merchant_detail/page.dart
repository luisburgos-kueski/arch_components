import 'package:arch_components/merchant_detail/view/bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'state/bloc.dart';

//TODO: Divide into classes, files and components
class MerchantDetailPage extends StatelessWidget {
  static String routeName = '/home/:id';

  const MerchantDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: Evaluate direct call to Get here is ok.
    final merchantName = Get.parameters['id'] as String;

    return BlocProvider(
      create: (_) => MerchantDetailBloc(),
      child: MerchantDetailView(
        merchantName: merchantName,
      ),
    );
  }
}
