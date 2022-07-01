import 'dart:convert';

import 'package:http/http.dart';
import 'package:kdata_sources/data_sources.dart';
import 'package:kdata_sources/data_sources_request.dart';
import 'package:kdata_sources/data_sources_settings.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  late Fixture fixture;

  setUp(() {
    fixture = Fixture();
  });

  group('DataSources init', () {
    test('init happy path', () async {
      final dataSources = await DataSources.init(
        DataSourcesSettings(
          appName: mockAppName,
          apiUri: dataSourcesApiUri,
          apiToken: mockApiToken,
        ),
        client: MockDataSourcesClient(),
      );

      expect(dataSources.appName, '<app-name>');
      expect(dataSources.apiUrl, 'http://test.kueski.com/api/v1/protected/');
      expect(dataSources.apiToken, '<mock-token>');
    });

    //TODO: Add error case
  });

  group('DataSources send data', () {
    test('logBehavior', () async {
      var callbackCalled = false;
      final dataSources = await DataSources.init(
        DataSourcesSettings(
          appName: mockAppName,
          apiUri: dataSourcesApiUri,
          apiToken: mockApiToken,
        ),

        ///TODO: Verify fixture is good practice, evaluate use mockito
        client: fixture.getStub((request) async {
          expect(
            request.url,
            Uri.parse('http://test.kueski.com/api/v1/protected/data-sources/'),
          );
          expect(request.method, 'POST');
          expect(request.headers, {
            'content-type': 'text/plain; charset=utf-8',
            'Authorization': '<mock-token>',
            'DATASOURCES-APPNAME': '<app-name>',
          });

          final dataSourcesRequest = DataSourcesRequest.fromJson(
            jsonDecode(request.body) as Map<String, dynamic>,
          );

          print(dataSourcesRequest);
          expect(dataSourcesRequest.name, 'log-behavior-event-name');
          expect(
            dataSourcesRequest.source,
            DataSourcesRequestTypes.logBehavior,
          );

          callbackCalled = true;
          return Response('', 200);
        }),
      );

      await dataSources.sendDataSourceRequest(
        name: 'log-behavior-event-name',
        source: DataSourcesRequestTypes.logBehavior,
      );

      expect(callbackCalled, isTrue);
    });
  });
}
