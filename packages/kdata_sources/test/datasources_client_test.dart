import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  late Fixture fixture;

  setUp(() {
    fixture = Fixture();
  });

  /*
  test('register successfully', () async {
    var callbackCalled = false;
    final client = fixture.getStub((request) async {
      expect(request.url, Uri.parse(dataSourcesPostUrl));
      expect(request.method, 'POST');
      expect(request.headers, {
        'Content-type': 'application/json; charset=utf-8',
        'Authorization': mockApiToken,
      });

      final register = DataSourcesRequest.fromJson(
        jsonDecode(request.body) as Map<String, dynamic>,
      );

      expect(register.appName, 'foo');
      expect(register.instanceId, 'bar');
      expect(register.started, DateTime(2021, 01, 01, 01, 01));

      callbackCalled = true;
      return Response('', 200);
    });

    await client.sendDataSourcesRequest();

    expect(callbackCalled, isTrue);
  });

  test('register does not throw on failing request', () async {
    final client = fixture.getStub((request) async {
      throw Exception();
    });
    await client.sendDataSourcesRequest();
    expect(1, 1);
  });

  test('getFeatureToggles returns null on failing request', () async {
    final client = fixture.getStub((request) async {
      throw Exception();
    });
    final features = await client.sendDataSourcesRequest();
    expect(features, null);
  });*/
}
