import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:kapp_behavior/kapp_behavior.dart';

///TODO: Add clear events cache log action
class AppBehaviorScreen extends StatelessWidget {
  static const String routeName = "/app-behavior";

  static KAppBehaviorInMemoryStore eventsStore = KAppBehaviorInMemoryStore();

  const AppBehaviorScreen({
    Key? key,
    this.customColorDecorator,
    this.onBackPressed,
    this.backButtonWidget,
  }) : super(key: key);

  final Color Function(KAppBehaviorEvent)? customColorDecorator;
  final Function()? onBackPressed;
  final Widget? backButtonWidget;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onBackPressed: onBackPressed,
      appBar: AppBar(
        leading: backButtonWidget,
        title: const Text(
          AppBehaviorScreen.routeName,
        ),
        actions: [
          ///This widget is not using notifiers intentionally for now.
          IconButton(
            icon: const Icon(Icons.delete_forever_sharp),
            onPressed: () {
              eventsStore.wipeList();
            },
          ),
        ],
      ),
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
      stream: AppBehaviorScreen.eventsStore.listStateChanges(),
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

  //TODO:
  // Improve decoration pattern by receiving a custom decoration by event-type.
  Color _getDecorationColor(KAppBehaviorEvent event) {
    if (colorDecorator != null) {
      return colorDecorator!(event);
    }
    if (event is KAppBehaviorUiEvent) {
      return Colors.blue.shade300;
    }
    if (event is KAppBehaviorBusinessLogicEvent) {
      return Colors.red.shade300;
    }
    if (event is KAppBehaviorUseCaseEvent) {
      return Colors.yellow.shade300;
    }
    if (event is KAppBehaviorScreenEvent) {
      return Colors.green.shade300;
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

class KAppBehaviorInMemoryStore {
  final _state = InMemoryStore<List<KAppBehaviorEvent>>([]);

  Stream<List<KAppBehaviorEvent>> listStateChanges() => _state.stream;

  List<KAppBehaviorEvent> get currentList => _state.value;

  Future<void> loadList() async {
    //TODO: Implement loading items from a local file or a remote.
  }

  Future<void> wipeList() async {
    _state.value = [];
  }

  void dispose() => _state.close();

  void add(KAppBehaviorEvent event) {
    ///TODO: Add async call to send data to remote.
    _state.value.add(event);
  }
}
