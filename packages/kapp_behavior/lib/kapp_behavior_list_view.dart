import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

class AppBehaviorScreen extends StatelessWidget {
  static const String routeName = "/app-behavior";

  const AppBehaviorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      withSafeArea: true,
      body: KAppBehaviorListView(),
    );
  }
}

class KAppBehaviorListView extends StatelessWidget {
  const KAppBehaviorListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ManagedStreamBuilder<List<KAppBehaviorEvent>>(
      stream: KAppBehavior().eventsStore.listStateChanges(),
      onLoading: () => const Center(child: CircularProgressIndicator()),
      onData: (data) => AppBehaviorEventsListView(items: data ?? const []),
      onError: (error) => Center(child: Text(error)),
    );
  }
}

class AppBehaviorEventsListView extends StatelessWidget {
  const AppBehaviorEventsListView({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<KAppBehaviorEvent> items;

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

        return ListTile(
          leading: Text('${index + 1}'),
          title: Text('${event.name} - ${event.timestamp.toIso8601String()}'),
          subtitle: Text(event.params?.toString() ?? 'No params'),
        );
      },
    );
  }
}
