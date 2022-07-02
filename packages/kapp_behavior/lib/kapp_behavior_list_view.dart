import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

///TODO: Add clear events cache log action
class AppBehaviorScreen extends StatelessWidget {
  static const String routeName = "/app-behavior";

  const AppBehaviorScreen({
    Key? key,
    this.customColorDecorator,
  }) : super(key: key);

  final Color Function(KAppBehaviorEvent)? customColorDecorator;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      withSafeArea: true,
      body: KAppBehaviorListView(
        customColorDecorator: customColorDecorator,
      ),
    );
  }
}

class KAppBehaviorListView extends StatelessWidget {
  const KAppBehaviorListView({
    Key? key,
    this.customColorDecorator,
  }) : super(key: key);

  final Color Function(KAppBehaviorEvent)? customColorDecorator;

  @override
  Widget build(BuildContext context) {
    return ManagedStreamBuilder<List<KAppBehaviorEvent>>(
      stream: KAppBehavior.eventsStore.listStateChanges(),
      onLoading: () => const Center(child: CircularProgressIndicator()),
      onData: (data) => AppBehaviorEventsListView(
        items: data ?? const [],
        colorDecorator: customColorDecorator,
      ),
      onError: (error) => Center(child: Text(error)),
    );
  }
}

class AppBehaviorEventsListView extends StatelessWidget {
  const AppBehaviorEventsListView({
    Key? key,
    required this.items,
    this.colorDecorator,
  }) : super(key: key);

  final List<KAppBehaviorEvent> items;
  final Color Function(KAppBehaviorEvent)? colorDecorator;

  Color _getDecorationColor(KAppBehaviorEvent event) {
    if (colorDecorator == null) return Colors.grey;
    return colorDecorator!(event);
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('No items yet'),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final event = items[index];

        return Container(
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              child: Center(
                child: Text('${index + 1}'),
              ),
              decoration: BoxDecoration(
                color: _getDecorationColor(event),
                shape: BoxShape.circle,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.params != null) ...[
                  const SizedBox(height: 4),
                  Text(event.params.toString()),
                ],
                const SizedBox(height: 6),
                Text(event.timestamp.toIso8601String()),
              ],
            ),
          ),
        );
      },
    );
  }
}
