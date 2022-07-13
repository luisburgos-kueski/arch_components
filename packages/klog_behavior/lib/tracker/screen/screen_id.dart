import '../../utils/constants.dart';

@Deprecated('Will be removed in v2.0')
class ScreenId {
  final String _id;

  const ScreenId({
    required String id,
  }) : _id = id;

  const ScreenId.defaultId() : _id = defaultScreenId;

  String get id => _id;

  @override
  String toString() {
    return _id;
  }
}
