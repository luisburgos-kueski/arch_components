import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import 'view_data_model.dart';

class MerchantsList extends StatelessWidget {
  const MerchantsList({
    Key? key,
    required this.items,
    required this.onMerchantItemClicked,
  }) : super(key: key);

  final List<MerchantViewData> items;
  final Function(MerchantViewData) onMerchantItemClicked;

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
        return MerchantListTile(
          item: item,
          onMerchantItemClicked: onMerchantItemClicked,
        );
      },
    );
  }
}

class MerchantListTile extends StatelessWidget {
  const MerchantListTile({
    Key? key,
    required this.item,
    required this.onMerchantItemClicked,
  }) : super(key: key);

  final MerchantViewData item;
  final Function(MerchantViewData) onMerchantItemClicked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      onTap: () {
        onMerchantItemClicked(item);
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
    return TextButton(
      onPressed: () {
        if (onLoad != null) onLoad!();
      },
      child: const Text('Load merchants data'),
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
    return TextButton(
      onPressed: () {
        ///TODO: Could this trigger an AppBehavior event?
        KMessenger.showSnackBar(context, 'Long press to clear');
      },
      onLongPress: () {
        if (onClear != null) onClear!();
      },
      child: const Text('Clear merchants data'),
    );
  }
}

class ActionsIconButton extends StatelessWidget {
  const ActionsIconButton({
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
