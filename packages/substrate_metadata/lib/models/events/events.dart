part of models;

class EventMetadataV9 {
  final String name;
  final List<String> args;
  final List<String> docs;
  const EventMetadataV9(
      {required this.name, required this.args, required this.docs});

  /// Creates Class Object from `Json`
  static EventMetadataV9 fromJson(Map<String, dynamic> map) => EventMetadataV9(
        name: map['name'],
        args: (map['args'] as List).cast<String>(),
        docs: (map['docs'] as List).cast<String>(),
      );
}
