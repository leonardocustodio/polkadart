part of models;

/// Metadata about an event
class EventInfo {
  final String name;
  final String palletName;
  final int index;
  final List<FieldInfo> fields;
  final List<String> docs;

  const EventInfo({
    required this.name,
    required this.palletName,
    required this.index,
    required this.fields,
    this.docs = const [],
  });

  String get identifier => '$palletName.$name';
}
