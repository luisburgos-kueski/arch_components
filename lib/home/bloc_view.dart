import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'components.dart';
import 'view_data_model.dart';
import 'view_template.dart';

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
                    NavigateToMerchantDetailEvent(merchantData),
                  );
            },
          ),
          failureViewBuilder: () => const Center(
            child: Text('TODO: Handle error'),
          ),
          onLoadMerchantsPressed: () {
            context.read<HomeBloc>().add(LoadMerchantsEvent());
          },
          onClearMerchantsPressed: () {
            context.read<HomeBloc>().add(ClearMerchantsEvent());
          },
        );
      },
    );
  }
}
