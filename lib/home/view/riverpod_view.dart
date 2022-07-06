import 'package:arch_components/home/shared/view_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/view_template.dart';
import '../state/riverpod.dart';
import 'components.dart';

class HomeRiverpodView extends ConsumerWidget {
  const HomeRiverpodView({Key? key}) : super(key: key);

  HomeScreenRiverpodController _controller(WidgetRef ref) =>
      ref.read(homeScreenControllerProvider.notifier);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
