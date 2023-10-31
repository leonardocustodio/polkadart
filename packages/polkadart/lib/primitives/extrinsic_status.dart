part of primitives;

class ExtrinsicStatus {
  final String type;
  final dynamic value;

  const ExtrinsicStatus({
    required this.type,
    required this.value,
  });

  factory ExtrinsicStatus.fromJson(dynamic json) {
    String type;
    dynamic value;

    if (json is String) {
      type = json;
      value = null;
    } else if (json is Map<String, dynamic>) {
      type = json.keys.first;
      value = json[type];
    } else {
      throw Exception('ExtrinsicStatus: Invalid json value "$json"');
    }

    return ExtrinsicStatus(
      type: type,
      value: value,
    );
  }
}
