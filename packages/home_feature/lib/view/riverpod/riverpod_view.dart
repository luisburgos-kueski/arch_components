import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../redirections.dart';
import '../../view/components.dart';
import '../view_data_model.dart';
import '../view_template.dart';
import 'riverpod.dart';

class HomeRiverpodView extends ConsumerWidget {
  const HomeRiverpodView(
    this.redirections, {
    Key? key,
  }) : super(key: key);

  final HomeRedirections redirections;

  HomeScreenRiverpodController _controller(WidgetRef ref) =>
      ref.read(homeScreenControllerProvider.notifier);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// TODO:
    /// This might break Riverpod principles and violates build method rules.
    _controller(ref).redirections = redirections;
    final AsyncValue<void> state = ref.watch(homeScreenControllerProvider);
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return HomeViewTemplate(
      tag: 'riverpod',
      merchantsList: _MerchantsListDataWatcher(
        onGoToMerchantDetail: (d) {
          _controller(ref).navigateToMerchantDetail(d);
        },
      ),
      failureViewBuilder: () => Container(),
      onLoadMerchantsPressed: () {
        _controller(ref).loadMerchants();
      },
      onClearMerchantsPressed: () {
        _controller(ref).clearMerchants();
      },
      onSettingsPressed: () {
        _controller(ref).navigateToSettings();
      },
      onClearMerchantsTrunked: () {
        _controller(ref).displayClearActionInstructions(
          () {
            KMessenger.showSnackBar(context, 'Long press to clear');
          },
        );
      },
    );
  }
}

class _MerchantsListDataWatcher extends ConsumerWidget {
  const _MerchantsListDataWatcher({
    Key? key,
    required this.onGoToMerchantDetail,
  }) : super(key: key);

  final Function(MerchantViewData) onGoToMerchantDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: Review MerchantsList design is compatible with maybeWhen design.
    final state = ref.watch(merchantListStateChangesProvider);
    return state.maybeWhen(
      loading: () => MerchantsList(
        items: const [],
        onMerchantItemClicked: onGoToMerchantDetail,
      ),
      orElse: () => MerchantsList(
        items: const [],
        onMerchantItemClicked: onGoToMerchantDetail,
      ),
      data: (data) => MerchantsList(
        items: data,
        onMerchantItemClicked: onGoToMerchantDetail,
      ),
    );
  }
}
