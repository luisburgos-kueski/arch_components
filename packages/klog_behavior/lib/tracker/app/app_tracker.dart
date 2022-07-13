import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../event/app_event.dart';
import '../../manager/event_manager.dart';
import '../../utils/constants.dart';
import '../event_tracker.dart';
import 'app_id.dart';

@Deprecated('Use [AppLifecycleNotifier]')
class AppTracker extends StatefulWidget {
  final AppId appId;
  final Widget child;
  final bool provideAppId;
  final bool enabled;

  const AppTracker({
    Key? key,
    this.appId = const AppId.defaultId(),
    required this.child,
    this.provideAppId = true,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AppTracker> createState() => _AppTrackerState();
}

class _AppTrackerState extends State<AppTracker>
    with WidgetsBindingObserver, EventTracker {
  EventManager? _manager;
  String _compoundId = '';

  @override
  bool get enabled => widget.enabled;

  @override
  EventManager? get manager => _manager;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    _initEventManager();
    _initCompoundId();
    return widget.provideAppId
        ? Provider<AppId>(
            create: (context) => widget.appId,
            child: widget.child,
          )
        : widget.child;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        trackEvent(AppEvent.resumed(componentId: _compoundId));
        break;
      case AppLifecycleState.inactive:
        trackEvent(AppEvent.inactive(componentId: _compoundId));
        break;
      case AppLifecycleState.paused:
        trackEvent(AppEvent.paused(componentId: _compoundId));
        break;
      case AppLifecycleState.detached:
        trackEvent(AppEvent.detached(componentId: _compoundId));
        break;
    }
  }

  void _initEventManager() {
    try {
      _manager ??= context.read<EventManager>();
    } catch (e) {
      throw Exception(eventManagerErrorMessage);
    }
  }

  void _initCompoundId() {
    _compoundId = widget.appId.id;
  }
}
