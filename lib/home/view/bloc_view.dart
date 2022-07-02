import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/view_data_model.dart';
import '../shared/view_template.dart';
import '../state/bloc.dart';
import 'components.dart';

class HomeBlocView extends StatelessWidget {
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
                    NavigateToMerchantDetailPressed(merchantData),
                  );
            },
          ),
          failureViewBuilder: () => const Center(
            child: Text('TODO: Handle error'),
          ),
          onSettingsPressed: () {
            context.read<HomeBloc>().add(NavigateToSettingsPressed());
          },
          onLoadMerchantsPressed: () {
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
