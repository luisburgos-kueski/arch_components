import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import 'components.dart';

class MerchantName {
  const MerchantName(this.value);
  final String value;
}

class HomeViewTemplate extends StatelessWidget {
  const HomeViewTemplate({
    Key? key,
    required this.tag,
    this.isLoading = false,
    this.displayFailure = false,
    required this.failureViewBuilder,
    required this.merchantsList,
    required this.onLoadMerchants,
    required this.onClearMerchants,
  }) : super(key: key);

  final String tag;
  final MerchantsList merchantsList;
  final Function() onLoadMerchants;
  final Function() onClearMerchants;
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
                                  onLoad: onLoadMerchants,
                                ),
                                ClearMerchantsTextButton(
                                  onClear: onClearMerchants,
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
