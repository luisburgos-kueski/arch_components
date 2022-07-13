import '../../utils/constants.dart';

@Deprecated('Will be removed in v2.0')
class WidgetId {
  final String _id;

  const WidgetId({
    required String id,
  }) : _id = id;

  const WidgetId.defaultId() : _id = defaultWidgetId;

  String get id => _id;

  @override
  String toString() {
    return _id;
  }
}
