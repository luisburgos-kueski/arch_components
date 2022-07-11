import 'package:arch_components/merchant_detail/state/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view_template.dart';

@Deprecated('Use MerchantDetailScreen from merchant_detail_feature')
class MerchantDetailView extends StatelessWidget {
  const MerchantDetailView({
    Key? key,
    required this.merchantName,
  }) : super(key: key);

  final String merchantName;

  @override
  Widget build(BuildContext context) {
    return MerchantDetailViewTemplate(
      merchantName: merchantName,
      onBackButtonPressed: () {
        context.read<MerchantDetailBloc>().add(CloseMerchantDetail());
      },
    );
  }
}
