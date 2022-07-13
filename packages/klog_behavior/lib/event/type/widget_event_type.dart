import 'event_type.dart';

@Deprecated('Will be removed in v2.0')
enum WidgetEventEnum {
  widgetTapped,
  widgetFocused,
  widgetUnfocused,
  widgetValueChanged,
  widgetValueCut,
  widgetValuePasted,
  widgetValueSelected,
  widgetScrollUp,
  widgetScrollDown,
  widgetScrollRight,
  widgetScrollLeft,
  widgetEnabled,
  widgetDisabled,
  widgetSelected,
  widgetDeselected,
}

@Deprecated('Will be removed in v2.0')
class WidgetEventType implements EventType {
  final String _name;

  static final Map<WidgetEventEnum, WidgetEventType> _cache =
      <WidgetEventEnum, WidgetEventType>{};

  static WidgetEventType _getWidgetEventType({required WidgetEventEnum type}) {
    if (_cache.containsKey(type)) {
      return _cache[type]!;
    }
    final WidgetEventType instance = WidgetEventType._internal(name: type.name);
    _cache[type] = instance;
    return instance;
  }

  factory WidgetEventType.tapped() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetTapped);
  }

  factory WidgetEventType.focused() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetFocused);
  }

  factory WidgetEventType.unfocused() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetUnfocused);
  }

  factory WidgetEventType.valueChanged() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetValueChanged);
  }

  factory WidgetEventType.valueCut() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetValueCut);
  }

  factory WidgetEventType.valuePasted() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetValuePasted);
  }

  factory WidgetEventType.valueSelected() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetValueSelected);
  }

  factory WidgetEventType.scrollUp() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetScrollUp);
  }

  factory WidgetEventType.scrollDown() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetScrollDown);
  }

  factory WidgetEventType.scrollRight() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetScrollRight);
  }

  factory WidgetEventType.scrollLeft() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetScrollLeft);
  }

  factory WidgetEventType.enabled() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetEnabled);
  }

  factory WidgetEventType.disabled() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetDisabled);
  }

  factory WidgetEventType.selected() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetSelected);
  }

  factory WidgetEventType.deselected() {
    return _getWidgetEventType(type: WidgetEventEnum.widgetDeselected);
  }

  WidgetEventType._internal({required String name}) : _name = name;

  @override
  String get name => _name;
}
