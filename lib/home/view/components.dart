import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

import '../../utils.dart';
import '../shared/view_data_model.dart';

class MerchantsList extends StatelessWidget {
  const MerchantsList({
    Key? key,
    required this.items,
    required this.onGoToMerchantDetail,
  }) : super(key: key);

  final List<MerchantViewData> items;
  final Function(MerchantViewData) onGoToMerchantDetail;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text(
        'Merchants data is empty',
        style: TextStyle(
          color: Colors.black,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return UiEventNotifier(
          key: Key('merchant_list_tile_${item.id}'),
          builder: (widgetId, publisher) {
            return ListTile(
              title: Text(item.name),
              onTap: () {
                publisher.publishUiEvent(
                  OnClicked(widgetId: widgetId),
                );
                onGoToMerchantDetail(item);
              },
            );
          },
        );
      },
    );
  }
}

class LoadMerchantsTextButton extends StatelessWidget {
  const LoadMerchantsTextButton({
    Key? key,
    this.onLoad,
  }) : super(key: key);

  final Function()? onLoad;

  @override
  Widget build(BuildContext context) {
    return UiEventNotifier(
      key: const Key('load_merchants_text_button'),
      builder: (widgetId, publisher) => TextButton(
        onPressed: () {
          publisher.publishUiEvent(
            OnClicked(widgetId: widgetId),
          );
          if (onLoad != null) onLoad!();
        },
        child: const Text('Load merchants data'),
      ),
    );
  }
}

class ClearMerchantsTextButton extends StatelessWidget {
  const ClearMerchantsTextButton({
    Key? key,
    this.onClear,
  }) : super(key: key);

  final Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return UiEventNotifier(
      key: const Key('clear_merchants_text_button'),
      builder: (widgetId, publisher) => TextButton(
        onPressed: () {
          publisher.publishUiEvent(
            OnClicked(widgetId: widgetId),
          );

          ///TODO: Could this trigger an AppBehavior event?
          showSnackBar(context, 'Long press to clear');
        },
        onLongPress: () {
          publisher.publishUiEvent(
            OnLongClicked(widgetId: widgetId),
          );
          if (onClear != null) onClear!();
        },
        child: const Text('Clear merchants data'),
      ),
    );
  }
}
