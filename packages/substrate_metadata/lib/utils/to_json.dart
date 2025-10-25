part of utils;

/// Returns normalized Json to Human readable format
extension ToJson<T> on T {
  T toJson() {
    return _convertToJsonRecursive(this) as T;
  }

  String toHuman() {
    final converted = _convertToJsonRecursive(this);
    if (converted is List || converted is Map) {
      return jsonEncode(
        converted,
        // handle BigInt and other special types
        toEncodable: _encodeJson,
      );
    }
    return converted.toString();
  }
}

/// Recursively converts values to JSON-compatible format
dynamic _convertToJsonRecursive(dynamic value) {
  if (value is MapEntry) {
    // Convert MapEntry to Map with single key-value pair
    return {
      value.key.toString(): _convertToJsonRecursive(value.value),
    };
  } else if (value is Map) {
    // Recursively convert all map entries
    final result = <String, dynamic>{};
    value.forEach((k, v) {
      result[k.toString()] = _convertToJsonRecursive(v);
    });
    return result;
  } else if (value is List) {
    // Recursively convert all list items
    return value.map((item) => _convertToJsonRecursive(item)).toList();
  } else if (value is BigInt) {
    return value.toString();
  } else if (value is BitArray) {
    return value.toJson();
  } else if (value is Option) {
    return _extractSomeValue(value);
  }
  return value;
}

Object? _encodeJson(Object? value) {
  if (value is BigInt) {
    return value.toString();
  } else if (value is BitArray) {
    return value.toJson();
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
