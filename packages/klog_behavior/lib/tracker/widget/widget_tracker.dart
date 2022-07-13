import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../event/listener/on_widget_event_listener.dart';
import '../../event/type/component_type.dart';
import '../../event/type/widget_event_type.dart';
import '../../event/widget_event.dart';
import '../../manager/event_manager.dart';
import '../../utils/constants.dart';
import '../app/app_id.dart';
import '../event_tracker.dart';
import '../screen/screen_id.dart';
import 'widget_id.dart';

@Deprecated('Will be removed in v2.0')
typedef TrackedWidgetBuilder = Widget Function(
  BuildContext context,
  OnWidgetEventListener listener,
);

@Deprecated('Use [UiEventNotifier]')
class WidgetTracker extends StatefulWidget {
  final bool enabled;
  final WidgetId widgetId;
  final bool useCompoundId;
  final TrackedWidgetBuilder builder;

  const WidgetTracker({
    Key? key,
    this.enabled = true,
    this.widgetId = const WidgetId.defaultId(),
    this.useCompoundId = true,
    required this.builder,
  }) : super(key: key);

  @override
  _WidgetTrackerState createState() => _WidgetTrackerState();
}

class _WidgetTrackerState extends State<WidgetTracker>
    with EventTracker
    implements OnWidgetEventListener {
  EventManager? _manager;
  AppId? _appId;
  ScreenId? _screenId;
  String _compoundId = '';

  @override
  void onEvent({
    required ComponentType componentType,
    required WidgetEventType eventType,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  }) {
    trackEvent(
      WidgetEvent(
        id: _compoundId,
        componentType: componentType,
        widgetEventType: eventType,
        data: data,
        metadata: metadata,
      ),
    );
  }

  @override
  bool get enabled => widget.enabled;

  @override
  EventManager? get manager => _manager;

  @override
  Widget build(BuildContext context) {
    _initEventManager();
    _initAppId();
    _initScreenId();
    _initCompoundId();
    return widget.builder(context, this);
  }

  void _initEventManager() {
    try {
      _manager ??= context.read<EventManager>();
    } catch (e) {
      throw Exception(eventManagerErrorMessage);
    }
  }

  void _initAppId() {
    try {
      _appId ??= context.read<AppId>();
    } catch (e) {
      _appId = const AppId.defaultId();
    }
  }

  void _initScreenId() {
    try {
      _screenId ??= context.read<ScreenId>();
    } catch (e) {
      _screenId = const ScreenId.defaultId();
    }
  }

  void _initCompoundId() {
    if (widget.useCompoundId) {
      _compoundId = "${_appId?.id}-${_screenId?.id}-${widget.widgetId.id}";
    } else {
      _compoundId = widget.widgetId.id;
    }
  }
}
