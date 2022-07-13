abstract class KEvent {
  final DateTime timestamp;

  final String name;

  final String widgetId;

  final Map<String, dynamic>? data;

  KEvent({
    required this.name,
    required this.widgetId,
    this.data,
  }) : timestamp = DateTime.now();

  @override
  String toString() {
    return "[$name, $widgetId, $timestamp, $data]";
  }
}
