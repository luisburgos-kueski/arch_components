import 'package:kdata_sources/data_sources_request.dart';
import 'package:test/test.dart';

void main() {
  test('DataSourcesRequest.toJson', () {
    final request = DataSourcesRequest(
      name: 'name',
      source: DataSourcesRequestTypes.logBehavior,
    );

    expect(request.toJson(), <String, dynamic>{
      'name': 'name',
      'source': 'log_behavior',
    });
  });
}
