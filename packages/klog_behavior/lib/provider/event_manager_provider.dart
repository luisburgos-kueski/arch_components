import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/event_manager.dart';

@Deprecated('Will be removed in v2.0')
class EventManagerProvider extends StatelessWidget {
  final Widget child;
  final EventManager manager;

  const EventManagerProvider({
    Key? key,
    required this.child,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<EventManager>(
      create: (context) => manager,
      child: child,
    );
  }
}
