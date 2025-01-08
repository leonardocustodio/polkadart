part of 'package:ink_abi/interfaces/interfaces_base.dart';

class Params {
  final String name;
  final int type;

  const Params({
    required this.name,
    required this.type,
  });

  static Params fromJson(final Map<String, dynamic> json) {
    if (json['name'] == null || json['type'] == null) {
      throw Exception(
          'Exception as didn\'t found the name neither the type for this json: $json');
    }
    return Params(
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}
