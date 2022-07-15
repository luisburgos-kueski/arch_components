import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class HomeViewTemplate extends StatelessWidget {
  const HomeViewTemplate({
    Key? key,
    required this.tag,
    this.isLoading = false,
    this.displayFailure = false,
    required this.failureViewBuilder,
    required this.merchantsList,
    required this.onLoadMerchantsPressed,
    required this.onClearMerchantsPressed,
    this.onSettingsPressed,
    this.onSecondSettingsPressed,
    required this.onClearMerchantsTrunked,
  }) : super(key: key);

  final String tag;
  final Widget merchantsList;
  final Function()? onSettingsPressed;
  final Function()? onSecondSettingsPressed;
  final Function() onLoadMerchantsPressed;
  final Function() onClearMerchantsPressed;
  final Function() onClearMerchantsTrunked;
  final Widget Function() failureViewBuilder;

  final bool displayFailure;
  final bool isLoading;

  Map<String, dynamic> get viewParams => {
        'tag': tag,
        'displayFailure': displayFailure,
        'isLoading': isLoading,
      };

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      withSafeArea: true,
      appBar: AppBar(
        title: Text(
          'Home Screen ($tag)',
        ),
        actions: [
          if (onSettingsPressed != null)
            ActionsIconButton(
              name: 'app_behavior',
              iconData: Icons.local_see_outlined,
              onTap: onSettingsPressed!,
            ),
          if (onSecondSettingsPressed != null)
            ActionsIconButton(
              name: 'log_behavior',
              iconData: Icons.biotech_outlined,
              onTap: onSecondSettingsPressed!,
            ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (displayFailure) {
            return Center(child: failureViewBuilder());
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: merchantsList),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      LoadMerchantsTextButton(
                        onLoad: onLoadMerchantsPressed,
                      ),
                      ClearMerchantsTextButton(
                        onShortClick: onClearMerchantsTrunked,
                        onClear: onClearMerchantsPressed,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
