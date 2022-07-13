import '../../utils/constants.dart';
import '../k_event.dart';

abstract class NavigationEvent extends KEvent {
  NavigationEvent({
    required String name,
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: name,
          widgetId: widgetId,
          data: data,
        );
}

class OnRoutePushed extends NavigationEvent {
  OnRoutePushed({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onRoutePushed,
          widgetId: widgetId,
          data: data,
        );
}

class OnRoutePopped extends NavigationEvent {
  OnRoutePopped({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onRoutePopped,
          widgetId: widgetId,
          data: data,
        );
}
