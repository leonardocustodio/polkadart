import 'dart:convert';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;

/// Returns normalized Json to Human readable format
extension ToJson<T> on T {
  T toJson() {
    if (this is List<T>) {
      return (this as List<T>).map((T e) => e.toJson()).toList() as T;
    }
    if (this is List<Map<String, dynamic>> || this is Map<String, dynamic>) {
      return jsonDecode(toHuman());
    }
    return this;
  }

  String toHuman() {
    if (this is scale.Some<dynamic>) {
      return toString();
    }

    if (this is List<Map<String, dynamic>> || this is Map<String, dynamic>) {
      return jsonEncode(
        this,
        // handle BigInt and Some / None
        toEncodable: _encodeJson,
      );
    }
    return toString();
  }
}

Object? _encodeJson(Object? value) {
  if (value is BigInt) {
    return value.toString();
  } else if (value is scale.Some) {
    return _extractSomeValue(value);
  } else if (value is scale.NoneOption) {
    return null;
  } else if (value is MapEntry) {
    final v = <String, dynamic>{
      value.key: _encodeJson(value.value),
    };
    return v;
  }
  return value;
}

dynamic _extractSomeValue(scale.Some value) {
  if (value.value is scale.Some) {
    return _extractSomeValue(value.value as scale.Some);
  }
  if (value.value == scale.None) {
    return null;
  }
  return value.value;
}
