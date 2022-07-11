import 'package:core/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchant_detail_feature/view/ui_events.dart';

import '../view_template.dart';
import 'bloc.dart';
import 'bloc_events.dart';

class MerchantDetailBlocView extends StatelessWidget
    with OnBackPressedAppBehaviorNotifier, KAppBehaviorUiNotifier {
  const MerchantDetailBlocView({
    Key? key,
    required this.merchantName,
  }) : super(key: key);

  final String merchantName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MerchantDetailBloc>(
      create: (_) => MerchantDetailBloc(),
      child: BlocBuilder<MerchantDetailBloc, MerchantDetailState>(
        builder: (context, state) => BaseScaffold(
          body: MerchantDetailViewTemplate(
            merchantName: merchantName,
            onBackToHomeTextButtonClicked: () {
              notifyUi(OnBackToHomeTextButtonPressed());
              notifyOnBackPressed(
                fromRoute: Get.currentRoute,
                source: BackSource.user,
              );
              context.read<MerchantDetailBloc>().add(CloseMerchantDetail());
            },
            onBackPressed: () {
              notifyOnBackPressed(
                fromRoute: Get.currentRoute,
              );
            },
          ),
        ),
      ),
    );
  }
}
