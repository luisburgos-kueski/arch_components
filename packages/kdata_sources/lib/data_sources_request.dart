enum DataSourcesRequestTypes {
  logBehavior,
  appBehavior,
  deviceInfo,
}

extension DataSourcesRequestTypesParse on DataSourcesRequestTypes {
  static DataSourcesRequestTypes parse(String rawName) {
    if (rawName == 'log_behavior') return DataSourcesRequestTypes.logBehavior;
    if (rawName == 'app_behavior') return DataSourcesRequestTypes.appBehavior;
    if (rawName == 'device_info') return DataSourcesRequestTypes.deviceInfo;
    //TODO: Validate naming.
    throw ArgumentError.value(
      rawName,
      'source',
      'Type for "$rawName" is not supported',
    );
  }
}

class DataSourcesRequest {
  DataSourcesRequest({
    required this.name,
    required this.source,
    this.timestamp,
    this.payload,
    this.metadata,
  });

  final String name;

  ///TODO: Evaluate renaming to be requestType or source;
  final DataSourcesRequestTypes source;
  DateTime? timestamp;
  Map<String, dynamic>? payload;
  Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() => {
        'name': name,
        'source': source.nameInSnakeCase,
        if (timestamp != null) 'timestamp': timestamp,
        if (payload != null) 'payload': payload,
        if (metadata != null) 'metadata': metadata,
      };

  //TODO: Evaluate naming
  String format() {
    var event = 'Name: $name, Time: $timestamp, Source: ${source.name}';
    event += '], Payload: [';
    payload?.forEach(
      (key, value) => event += '($key: $value)',
    );
    event += '], Metadata: [';
    metadata?.forEach(
      (key, value) => event += '($key: $value)',
    );
    event += ']';
    return event;
  }

  //TODO: Add more attributes
  DataSourcesRequest.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        source = DataSourcesRequestTypesParse.parse(json['source'] as String);
}

extension _EnumExtension on Enum {
  /// This getter is to maintain the standard of firebase events names.
  String get nameInSnakeCase {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    return describeEnum(this)
        .replaceAllMapped(
          exp,
          (Match m) => ('_' + (m.group(0) ?? "")),
        )
        .toLowerCase();
  }

  String describeEnum(Object enumEntry) {
    if (enumEntry is Enum) return enumEntry.name;
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(
      indexOfDot != -1 && indexOfDot < description.length - 1,
      'The provided object "$enumEntry" is not an enum.',
    );
    return description.substring(indexOfDot + 1);
  }
}
