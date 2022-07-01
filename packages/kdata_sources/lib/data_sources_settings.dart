import 'package:path/path.dart';

class DataSourcesSettings {
  const DataSourcesSettings({
    required this.appName,
    required this.apiUri,
    this.apiToken,
    this.customHeaders = const {},
  });

  final String appName;
  final String? apiToken;
  final Uri apiUri;
  final Map<String, String> customHeaders;

  Map<String, String> toHeaders() => {
        'DATASOURCES-APPNAME': appName,
        'Authorization': apiToken ?? '',
        ...customHeaders,
      };

  /// URL to send GET requests to load toggles
  Uri get dataSourcesUrl => Uri.parse(
        join(apiUri.toString(), 'data-sources/'),
      );
}
