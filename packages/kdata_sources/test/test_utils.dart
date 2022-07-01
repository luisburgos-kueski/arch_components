import 'package:http/testing.dart';
import 'package:kdata_sources/data_sources_client.dart';
import 'package:kdata_sources/data_sources_request.dart';
import 'package:kdata_sources/data_sources_response.dart';
import 'package:kdata_sources/data_sources_settings.dart';

final mockAppName = '<app-name>';
final mockApiToken = '<mock-token>';
final dataSourcesApiUrl = 'http://test.kueski.com/api/v1/protected/';
final dataSourcesPostUrl = '${dataSourcesApiUrl}data-sources/';
final dataSourcesApiUri = Uri.parse(dataSourcesApiUrl);
final dataSourcesPostUri = Uri.parse(dataSourcesPostUrl);

class MockDataSourcesClient implements DataSourcesClient {
  @override
  Future<DataSourcesResponse?> sendDataSourcesRequest(
    DataSourcesRequest request,
  ) async {
    return null;
  }
}

///TODO: Research fixture
class Fixture {
  DataSourcesClient getStub(MockClientHandler handler) {
    return DataSourcesClient(
      settings: DataSourcesSettings(
        appName: mockAppName,
        apiToken: mockApiToken,
        apiUri: dataSourcesApiUri,
      ),
      client: MockClient(handler),
    );
  }
}
