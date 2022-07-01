import 'package:kdata_sources/data_sources_settings.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  group('DataSourcesSettings', () {
    test('toHeaders', () {
      final settings = DataSourcesSettings(
        appName: mockAppName,
        apiUri: dataSourcesApiUri,
        apiToken: mockApiToken,
      );

      expect(settings.toHeaders(), <String, String>{
        'DATASOURCES-APPNAME': '<app-name>',
        'Authorization': '<mock-token>',
      });
    });

    test('toHeaders with custom headers', () {
      final settings = DataSourcesSettings(
        appName: mockAppName,
        apiUri: dataSourcesApiUri,
        apiToken: mockApiToken,
        customHeaders: {
          'X-CUSTOM': 'CUSTOM_VALUE',
        },
      );

      expect(settings.toHeaders(), <String, String>{
        'DATASOURCES-APPNAME': '<app-name>',
        'Authorization': '<mock-token>',
        'X-CUSTOM': 'CUSTOM_VALUE',
      });
    });

    test('settings dataSourcesUrl', () {
      var settings = DataSourcesSettings(
        appName: mockAppName,
        apiUri: dataSourcesApiUri,
        apiToken: mockApiToken,
      );
      expect(
        settings.dataSourcesUrl,
        Uri.parse('http://test.kueski.com/api/v1/protected/data-sources/'),
      );
    });
  });
}
