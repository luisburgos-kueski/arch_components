import 'dart:developer';

import 'package:http/http.dart' as http;

import 'data_sources_client.dart';
import 'data_sources_request.dart';
import 'data_sources_response.dart';
import 'data_sources_settings.dart';

class DataSources {
  DataSources._internal(
    this.settings,
    this._dataSourcesClient,
  );

  final DataSourcesClient _dataSourcesClient;
  final DataSourcesSettings settings;

  static Future<DataSources> init(
    DataSourcesSettings settings, {
    DataSourcesClient? client,
  }) async {
    final dataSources = DataSources._internal(
      settings,
      client ?? DataSourcesClient(settings: settings, client: http.Client()),
    );
    log('${dataSources._dataSourcesClient.runtimeType}');
    return dataSources;
  }

  String get appName => settings.appName;
  String? get apiToken => settings.apiToken;
  String? get apiUrl => settings.apiUri.toString();

  Future<DataSourcesResponse?> sendDataSourceRequest({
    required String name,
    required DataSourcesRequestTypes source,
    DateTime? timestamp,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? metadata,
  }) async {
    return _dataSourcesClient.sendDataSourcesRequest(
      DataSourcesRequest(
        name: name,
        source: source,
        payload: payload,
        timestamp: timestamp,
        metadata: metadata,
      ),
    );
  }
}
