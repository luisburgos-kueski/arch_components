import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import '../shared/view_data_model.dart';
import '../shared/view_events.dart';
import '../shared/view_template.dart';
import '../state/bloc.dart';
import 'components.dart';

//TODO: Rename to HomeViewBloc?
class HomeBlocView extends StatelessWidget with KAppBehaviorEventNotifier {
  const HomeBlocView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return HomeViewTemplate(
            tag: 'bloc',
            isLoading: state.status == HomeStatus.loading,
            displayFailure: state.status == HomeStatus.failure,
            merchantsList: MerchantsList(
              items: state.merchantNames,
              onMerchantItemClicked: (merchantData) {
                context.read<HomeBloc>().add(
                      NavigateToMerchantDetail(merchantData),
                    );
              },
            ),
            failureViewBuilder: () => const Center(
              child: Text('TODO: Handle error'),
            ),
            onSettingsPressed: () {
              context.read<HomeBloc>().add(NavigateToSettings());
            },
            onLoadMerchantsPressed: () {
              context.read<HomeBloc>().add(LoadHomeMerchants());
            },
            onClearMerchantsPressed: () {
              context.read<HomeBloc>().add(ClearHomeMerchants());
            },
          );
        },
      ),
    );
  }
}
