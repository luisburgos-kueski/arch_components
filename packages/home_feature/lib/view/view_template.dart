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
    this.onLoadMerchantsPressed,
    this.onClearMerchantsPressed,
    this.onSettingsPressed,
  }) : super(key: key);

  final String tag;
  final Widget merchantsList;
  final Function()? onSettingsPressed;
  final Function()? onLoadMerchantsPressed;
  final Function()? onClearMerchantsPressed;
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
              iconData: Icons.settings,
              onTap: () {
                onSettingsPressed!();
              },
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
                      LoadMerchantsTextButton(onLoad: () {
                        if (onLoadMerchantsPressed != null) {
                          onLoadMerchantsPressed!();
                        }
                      }),
                      ClearMerchantsTextButton(onClear: () {
                        if (onClearMerchantsPressed != null) {
                          onClearMerchantsPressed!();
                        }
                      }),
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
