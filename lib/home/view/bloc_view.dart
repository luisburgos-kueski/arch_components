import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import '../shared/view_data_model.dart';
import '../shared/view_template.dart';
import '../state/bloc.dart';
import 'components.dart';

class HomeBlocView extends StatelessWidget with KAppBehaviorEventNotifier {
  const HomeBlocView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return HomeViewTemplate(
          tag: 'bloc',
          isLoading: state.status == HomeStatus.loading,
          displayFailure: state.status == HomeStatus.failure,
          merchantsList: MerchantsList(
            items: state.merchantNames,
            onGoToMerchantDetail: (merchantData) {
              context.read<HomeBloc>().add(
                    NavigateToMerchantDetailEvent(merchantData),
                  );
            },
          ),
          failureViewBuilder: () => const Center(
            child: Text('TODO: Handle error'),
          ),
          onLoadMerchantsPressed: () {
            notify(OnLoadMerchantsButtonPressed());
            context.read<HomeBloc>().add(LoadMerchantsPressed());
          },
          onClearMerchantsPressed: () {
            context.read<HomeBloc>().add(ClearMerchantsPressed());
          },
        );
      },
    );
  }
}

class OnLoadMerchantsButtonPressed with KAppBehaviorEvent2 {
  @override
  final String name = 'load_merchants_button_pressed';

  @override
  final Map<String, dynamic>? params;

  @override
  final DateTime timestamp;

  OnLoadMerchantsButtonPressed({this.params}) : timestamp = DateTime.now();
}
