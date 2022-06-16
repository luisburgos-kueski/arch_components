import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import '../view/components.dart';

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
  }) : super(key: key);

  final String tag;
  final Widget merchantsList;
  final Function()? onLoadMerchantsPressed;
  final Function()? onClearMerchantsPressed;
  final Widget Function() failureViewBuilder;
  final bool displayFailure;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    //TODO: Reduce hadouken
    return SafeArea(
      child: NavigationNotifier(
        key: const Key('home_screen'),
        child: Scaffold(
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : displayFailure
                  ? Center(child: failureViewBuilder())
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Home Screen ($tag)',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Expanded(child: merchantsList),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                LoadMerchantsTextButton(
                                  onLoad: onLoadMerchantsPressed,
                                ),
                                ClearMerchantsTextButton(
                                  onClear: onClearMerchantsPressed,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
