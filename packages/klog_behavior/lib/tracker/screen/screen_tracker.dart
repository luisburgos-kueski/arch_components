import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../event/screen_event.dart';
import '../../manager/event_manager.dart';
import '../../utils/constants.dart';
import '../app/app_id.dart';
import '../event_tracker.dart';
import '../screen/screen_id.dart';

@Deprecated('Use [NavigationNotifier]')
class ScreenTracker extends StatefulWidget {
  final ScreenId screenId;
  final bool provideScreenId;
  final bool useCompoundId;
  final Widget child;
  final bool enabled;

  const ScreenTracker({
    Key? key,
    this.screenId = const ScreenId.defaultId(),
    this.provideScreenId = true,
    this.useCompoundId = true,
    this.enabled = true,
    required this.child,
  }) : super(key: key);

  @override
  _ScreenTrackerState createState() => _ScreenTrackerState();
}

class _ScreenTrackerState extends State<ScreenTracker>
    with RouteAware, EventTracker {
  RouteObserver<PageRoute>? _routeObserver;
  EventManager? _manager;
  AppId? _appId;
  String _compoundId = '';

  @override
  bool get enabled => widget.enabled;

  @override
  EventManager? get manager => _manager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscribeRouteObserver();
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now top most route.
    trackEvent(
      ScreenEvent.opened(componentId: _compoundId),
    );
  }

  @override
  void didPop() {
    // Covering route was popped off the navigator.
    trackEvent(
      ScreenEvent.closed(componentId: _compoundId),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initEventManager();
    _initRouteObserver();
    _initAppId();
    _initCompoundId();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => _subscribeRouteObserver(),
    );
    return widget.provideScreenId
        ? Provider<ScreenId>(
            create: (context) => widget.screenId,
            child: widget.child,
          )
        : widget.child;
  }

  void _initEventManager() {
    try {
      _manager ??= context.read<EventManager>();
    } catch (e) {
      throw Exception(eventManagerErrorMessage);
    }
  }

  void _initRouteObserver() {
    try {
      _routeObserver ??= context.read<RouteObserver<PageRoute>>();
    } catch (e) {
      throw Exception(routeObserverErrorMessage);
    }
  }

  void _initAppId() {
    try {
      _appId ??= context.read<AppId>();
    } catch (e) {
      _appId = const AppId.defaultId();
    }
  }

  void _initCompoundId() {
    if (widget.useCompoundId) {
      _compoundId = "${_appId?.id}-${widget.screenId.id}";
    } else {
      _compoundId = widget.screenId.id;
    }
  }

  void _subscribeRouteObserver() {
    var route = ModalRoute.of(context);
    if (route != null) {
      _routeObserver?.subscribe(this, route as PageRoute);
    }
  }
}
