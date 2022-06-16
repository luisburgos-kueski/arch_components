import 'package:arch_components/home/shared/view_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/view_template.dart';
import '../state/riverpod.dart';
import 'components.dart';

class HomeRiverpodView extends ConsumerWidget {
  const HomeRiverpodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(merchantListStateChangesProvider);
    if (state.isData) {
      return HomeViewTemplate(
        tag: 'riverpod',
        merchantsList: _MerchantsListDataWatcher(
          onGoToMerchantDetail: (d) {
            ref.read(homeScreenControllerProvider.notifier).navigateTo(d);
          },
        ),
        failureViewBuilder: () => Container(),
        onLoadMerchantsPressed: () {
          ref.read(homeScreenControllerProvider.notifier).loadMerchants();
        },
        onClearMerchantsPressed: () {
          ref.read(homeScreenControllerProvider.notifier).clearMerchants();
        },
      );
    }
    return const CircularProgressIndicator();
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
        onGoToMerchantDetail: onGoToMerchantDetail,
      ),
      orElse: () => MerchantsList(
        items: const [],
        onGoToMerchantDetail: onGoToMerchantDetail,
      ),
      data: (data) => MerchantsList(
        items: data,
        onGoToMerchantDetail: onGoToMerchantDetail,
      ),
    );
  }
}
