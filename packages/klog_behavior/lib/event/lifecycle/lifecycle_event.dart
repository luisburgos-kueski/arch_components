import '../../utils/constants.dart';
import '../k_event.dart';

abstract class LifecycleEvent extends KEvent {
  LifecycleEvent({
    required String name,
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: name,
          widgetId: widgetId,
          data: data,
        );
}

class OnAppPaused extends LifecycleEvent {
  OnAppPaused({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onAppPaused,
          widgetId: widgetId,
          data: data,
        );
}

class OnAppResumed extends LifecycleEvent {
  OnAppResumed({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onAppResumed,
          widgetId: widgetId,
          data: data,
        );
}

class OnAppDetached extends LifecycleEvent {
  OnAppDetached({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onAppDetached,
          widgetId: widgetId,
          data: data,
        );
}

class OnAppInactive extends LifecycleEvent {
  OnAppInactive({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onAppInactive,
          widgetId: widgetId,
          data: data,
        );
}
