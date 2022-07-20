import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

import '../../redirections.dart';
import '../../view/components.dart';
import '../ui_events.dart';
import '../view_data_model.dart';
import '../view_template.dart';
import 'bloc.dart';
import 'bloc_events.dart';

/// TODO: Rename to HomeViewBloc?
/// By using [KAppBehaviorUiNotifier] class and calling the
/// [KAppBehaviorUiNotifier.notifyUi] our `View` can log [KAppBehaviorUiEvent]s.
class HomeBlocView extends StatelessWidget with KAppBehaviorUiNotifier {
  const HomeBlocView(
    this.redirections, {
    Key? key,
  }) : super(key: key);

  final HomeRedirections redirections;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(redirections),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return HomeViewTemplate(
            tag: 'bloc',
            isLoading: state.status == HomeStatus.loading,
            displayFailure: state.status == HomeStatus.failure,
            merchantsList: MerchantsList(
              items: state.merchantNames,
              onMerchantItemClicked: (merchantData) {
                notifyUi(
                  MerchantTilePressed(
                    merchantName: merchantData.name,
                  ),
                );
                context.read<HomeBloc>().add(
                      NavigateToMerchantDetails(
                        merchantData,
                        redirections.merchantDetailPath,
                      ),
                    );
              },
            ),
            failureViewBuilder: () => const Center(
              child: Text('TODO: Handle error'),
            ),
            onSettingsPressed: () {
              notifyUi(AppBehaviorButtonPressed());
              context.read<HomeBloc>().add(NavigateToAppBehavior(
                    redirections.appBehaviorPath,
                  ));
            },
            onSecondSettingsPressed: () {
              notifyUi(LogBehaviorButtonPressed());
              context.read<HomeBloc>().add(NavigateToLogBehavior(
                    redirections.logBehaviorPath,
                  ));
            },
            onLoadMerchantsPressed: () {
              notifyUi(LoadMerchantsButtonPressed());
              context.read<HomeBloc>().add(LoadHomeMerchants());
            },
            onClearMerchantsPressed: () {
              notifyUi(ClearMerchantsButtonPressed());
              context.read<HomeBloc>().add(ClearHomeMerchants());
            },
            onClearMerchantsTrunked: () {
              ///TODO: Should we send some param to indicate this is not long.
              notifyUi(ClearMerchantsButtonPressed());
              context.read<HomeBloc>().add(ShowClearActionInstructions(
                () {
                  KMessenger.showSnackBar(context, 'Long press to clear');
                },
              ));
            },
          );
        },
      ),
    );
  }
}
