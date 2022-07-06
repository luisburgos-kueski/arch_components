import 'package:arch_components/home/view/components.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import 'ui_events.dart';

class HomeViewTemplate extends StatelessWidget with KAppBehaviorEventNotifier {
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
    return SafeArea(
      child: NavigationNotifier(
        key: const Key('home_screen'),
        child: BaseScaffold(
          appBar: AppBar(
            title: Text(
              'Home Screen ($tag)',
            ),
            actions: [
              if (onSettingsPressed != null)
                _ActionsIconButton(
                  iconData: Icons.settings,
                  onTap: () {
                    notifyUi(
                      OnSettingsButtonPressed(
                        params: viewParams,
                      ),
                    );
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
                            notifyUi(
                              OnLoadMerchantsButtonPressed(
                                params: viewParams,
                              ),
                            );
                            if (onLoadMerchantsPressed != null) {
                              onLoadMerchantsPressed!();
                            }
                          }),
                          ClearMerchantsTextButton(onClear: () {
                            notifyUi(
                              OnClearMerchantsButtonPressed(
                                params: viewParams,
                              ),
                            );
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
        ),
      ),
    );
  }
}

class _ActionsIconButton extends StatelessWidget {
  const _ActionsIconButton({
    Key? key,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);

  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(iconData),
      ),
    );
  }
}
