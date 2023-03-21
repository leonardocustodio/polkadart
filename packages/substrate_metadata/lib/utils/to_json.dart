part of utils;

/// Returns normalized Json to Human readable format
extension ToJson<T> on T {
  T toJson() {
    if (this is MapEntry) {
      return _encodeJson(this) as T;
    }
    if (this is List<T>) {
      return (this as List<T>).map((T e) => e.toJson()).toList(growable: false)
          as T;
    }
    if (this is List<dynamic>) {
      return (this as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> e) => e.toJson())
          .toList(growable: false) as T;
    }
    if (this is List<Map<String, dynamic>> || this is Map<String, dynamic>) {
      return jsonDecode(toHuman());
    }
    return this;
  }

  String toHuman() {
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
  } else if (value is Option) {
    return _extractSomeValue(value);
  } else if (value is MapEntry) {
    final v = <String, dynamic>{
      value.key: _encodeJson(value.value),
    };
    return v;
  }
  if (value is Map && value.isNotEmpty && value.keys.first is int) {
    final v = <String, dynamic>{};
    value.forEach((key, value) {
      v[key.toString()] = _encodeJson(value);
    });
    return v;
  }
  return value;
}

dynamic _extractSomeValue(Option value) {
  if (value.isSome) {
    return _encodeJson(value.value);
  }
  if (value.isNone) {
    return null;
  }
  return value.value;
}
