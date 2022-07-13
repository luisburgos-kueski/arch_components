import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'klog_behavior.dart';

///TODO: Add clear events cache log action
class LogBehaviorScreen extends StatelessWidget {
  static const String routeName = "/log-behavior";

  const LogBehaviorScreen({
    Key? key,
    this.customColorDecorator,
    this.onBackPressed,
  }) : super(key: key);

  final Color Function(KEvent)? customColorDecorator;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onBackPressed: onBackPressed,
      appBar: AppBar(
        title: const Text(
          LogBehaviorScreen.routeName,
        ),
      ),
      withSafeArea: true,
      body: KLogBehaviorListView(
        customColorDecorator: customColorDecorator,
      ),
    );
  }
}

class KLogBehaviorListView extends StatelessWidget {
  const KLogBehaviorListView({
    Key? key,
    this.customColorDecorator,
  }) : super(key: key);

  final Color Function(KEvent)? customColorDecorator;

  @override
  Widget build(BuildContext context) {
    return ManagedStreamBuilder<List<KEvent>>(
      stream: KLogBehavior.eventsStore.listStateChanges(),
      onLoading: () => const Center(child: CircularProgressIndicator()),
      onData: (data) => LogBehaviorEventsListView(
        items: data ?? const [],
        colorDecorator: customColorDecorator,
      ),
      onError: (error) => Center(child: Text(error)),
    );
  }
}

class LogBehaviorEventsListView extends StatelessWidget {
  const LogBehaviorEventsListView({
    Key? key,
    required this.items,
    this.colorDecorator,
  }) : super(key: key);

  final List<KEvent> items;
  final Color Function(KEvent)? colorDecorator;

  //TODO:
  // Improve decoration pattern by receiving a custom decoration by event-type.
  Color _getDecorationColor(KEvent event) {
    if (colorDecorator != null) {
      return colorDecorator!(event);
    }
    if (event is LifecycleEvent) {
      return Colors.blue.shade300;
    }
    if (event is UiEvent) {
      return Colors.red.shade300;
    }
    if (event is NavigationEvent) {
      return Colors.yellow.shade300;
    }
    return Colors.grey;
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
                const SizedBox(height: 4),
                Text('widgetId: ${event.widgetId}'),
                if (event.data != null) ...[
                  const SizedBox(height: 4),
                  Text(event.data.toString()),
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
