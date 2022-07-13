import '../../utils/constants.dart';
import '../k_event.dart';

abstract class UiEvent extends KEvent {
  UiEvent({
    required String name,
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: name,
          widgetId: widgetId,
          data: data,
        );
}

// TODO: PRODUCT-12283 Document that this event could be interpreted as OnTapped, OnPressed
class OnClicked extends UiEvent {
  OnClicked({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onClicked,
          widgetId: widgetId,
          data: data,
        );
}

class OnLongClicked extends UiEvent {
  OnLongClicked({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onLongClicked,
          widgetId: widgetId,
          data: data,
        );
}

class OnFocused extends UiEvent {
  OnFocused({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onFocused,
          widgetId: widgetId,
          data: data,
        );
}

class OnUnfocused extends UiEvent {
  OnUnfocused({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onUnfocused,
          widgetId: widgetId,
          data: data,
        );
}

class OnValueChanged extends UiEvent {
  OnValueChanged({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onValueChanged,
          widgetId: widgetId,
          data: data,
        );
}

class OnValueCut extends UiEvent {
  OnValueCut({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onValueCut,
          widgetId: widgetId,
          data: data,
        );
}

class OnValuePasted extends UiEvent {
  OnValuePasted({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onValuePasted,
          widgetId: widgetId,
          data: data,
        );
}

class OnScrollUp extends UiEvent {
  OnScrollUp({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onScrollUp,
          widgetId: widgetId,
          data: data,
        );
}

class OnScrollDown extends UiEvent {
  OnScrollDown({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onScrollDown,
          widgetId: widgetId,
          data: data,
        );
}

class OnScrollRight extends UiEvent {
  OnScrollRight({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onScrollRight,
          widgetId: widgetId,
          data: data,
        );
}

class OnScrollLeft extends UiEvent {
  OnScrollLeft({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onScrollLeft,
          widgetId: widgetId,
          data: data,
        );
}

class OnEnabled extends UiEvent {
  OnEnabled({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onEnabled,
          widgetId: widgetId,
          data: data,
        );
}

class OnDisabled extends UiEvent {
  OnDisabled({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onDisabled,
          widgetId: widgetId,
          data: data,
        );
}

class OnSelected extends UiEvent {
  OnSelected({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onSelected,
          widgetId: widgetId,
          data: data,
        );
}

class OnDeselected extends UiEvent {
  OnDeselected({
    required String widgetId,
    Map<String, dynamic>? data,
  }) : super(
          name: onDeselected,
          widgetId: widgetId,
          data: data,
        );
}
