import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components.dart';
import 'riverpod.dart';
import 'view_template.dart';

class HomeRiverpodView extends ConsumerWidget {
  const HomeRiverpodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantsDataState = ref.watch(merchantListStateChangesProvider);

    ///IMPORTANT: Using HomeViewTemplate as next is NOT suggested.
    return merchantsDataState.when(
      loading: () => HomeViewTemplate(
        tag: 'riverpod',
        isLoading: true,
        merchantsList: Container(),
        failureViewBuilder: () => Container(),
        onLoadMerchants: _onLoadMerchants,
        onClearMerchants: _onClearMerchants,
      ),
      error: (err, stack) => HomeViewTemplate(
        tag: 'riverpod',
        displayFailure: true,
        merchantsList: Container(),
        failureViewBuilder: () => Text('Oops! $err'),
        onLoadMerchants: _onLoadMerchants,
        onClearMerchants: _onClearMerchants,
      ),
      data: (data) => HomeViewTemplate(
        tag: 'riverpod',
        merchantsList: MerchantsList(
          items: data,
          onGoToMerchantDetail: (d) {
            ref.read(homeScreenControllerProvider.notifier).navigateTo(d);
          },
        ),
        failureViewBuilder: () => Container(),
        onLoadMerchants: () {
          ref.read(homeScreenControllerProvider.notifier).loadMerchants();
        },
        onClearMerchants: () {
          ref.read(homeScreenControllerProvider.notifier).clearMerchants();
        },
      ),
    );
  }

  void _onLoadMerchants() {}

  void _onClearMerchants() {}
}
