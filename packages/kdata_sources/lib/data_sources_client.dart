import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import 'data_sources_request.dart';
import 'data_sources_response.dart';
import 'data_sources_settings.dart';

/// Responsible for the communication with DataSources Server
class DataSourcesClient {
  DataSourcesClient({
    Client? client,
    required DataSourcesSettings settings,
  })  : _client = client ?? Client(),
        _settings = settings;

  final Client _client;
  final DataSourcesSettings _settings;

  Future<DataSourcesResponse?> sendDataSourcesRequest(
    DataSourcesRequest request,
  ) async {
    try {
      final response = await _client.post(
        _settings.dataSourcesUrl,
        headers: _settings.toHeaders(),
        body: json.encode(request.toJson()),
      );
      final stringResponse = utf8.decode(response.bodyBytes);

      return DataSourcesResponse.fromJson(
        json.decode(stringResponse) as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      log(
        'Could not send data sources request to server.\n'
        'Please make sure your configuration is correct.',
        name: 'data-sources',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }
}
