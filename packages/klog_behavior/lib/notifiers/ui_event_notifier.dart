import 'package:flutter/material.dart';

import '../../utils/key_extension.dart';
import '../event/kevent_observer.dart';
import '../event/ui/ui_event.dart';
import '../event/ui/ui_event_publisher.dart';
import '../observer_facade.dart';
import 'kueski_event_notifier.dart';

// TODO: PRODUCT-12283 Validate name UiEventNotifierBuilder
typedef UiEventNotifierBuilder = Widget Function(
  String widgetId,
  UiEventPublisher publisher,
);

class UiEventNotifier extends StatefulWidget {
  final bool enabled;
  final UiEventNotifierBuilder builder;

  const UiEventNotifier({
    required Key key,
    this.enabled = true,
    required this.builder,
  }) : super(key: key);

  @override
  _UiEventNotifierState createState() => _UiEventNotifierState();
}

class _UiEventNotifierState extends State<UiEventNotifier>
    with KEventNotifier
    implements UiEventPublisher {
  @override
  bool get enabled => widget.enabled;

  @override
  KEventObserver get eventObserver => KLogBehavior.eventObserver;

  @override
  String get widgetId => widget.key.value;

  @override
  Widget build(BuildContext context) {
    return widget.builder(widgetId, this);
  }

  @override
  void publishUiEvent(UiEvent event) {
    notify(event);
  }
}
