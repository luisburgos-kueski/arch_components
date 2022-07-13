import '../../utils/constants.dart';

@Deprecated('Will be removed in v2.0')
class AppId {
  final String _id;

  const AppId({
    required String id,
  }) : _id = id;

  const AppId.defaultId() : _id = defaultAppId;

  String get id => _id;

  @override
  String toString() {
    return _id;
  }
}
