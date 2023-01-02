import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import 'package:substrate_metadata/exceptions/exceptions.dart';

bool isNotEmpty(dynamic value) {
  if (value == null) {
    return false;
  }
  if (value is bool) {
    return value;
  } else if (value is String) {
    return value.trim() != '';
  } else if (value is num) {
    return value != 0;
  } else if (value is Map) {
    return value.isNotEmpty;
  } else if (value is List) {
    return value.isNotEmpty;
  }
  throw UnexpectedTypeException('Unexpected Type: $value.');
}

List<Map<String, dynamic>> flatten(List<List<Map<String, dynamic>>> list) {
  var result = <Map<String, dynamic>>[];
  for (var value in list) {
    for (var val in value) {
      result.add(val);
    }
  }
  return result;
}

/// Asserts if the `T` value is null or not.
///
/// Returns `T` if not null otherwise throws `AssertionException`
T assertNotNull<T>(T? val, [String? message]) {
  if (val == null) {
    throw AssertionException(message ?? 'Assertion Error occured.');
  }
  return val;
}

/// Asserts if the [val] value is true or not
///
/// Throws `AssertionException` if `false`
void assertionCheck(bool val, [String? message]) {
  if (!val) {
    throw AssertionError(message ?? 'Assertion Error occured.');
  }
}

String sha256(dynamic data) {
  late String content;

  if (data is String) {
    content = data;
  } else {
    // stringify the hashmap
    content = jsonEncode(data);
  }

  final algorithm = Blake2bDigest();

  final bytes = algorithm.process(Uint8List.fromList(utf8.encode(content)));

  return scale.encodeHex(bytes);
}

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
    if (this is List<Map<String, dynamic>> || this is Map<String, dynamic>) {
      return jsonEncode(
        this,
        // handle BigInt and Some / None
        toEncodable: (value) {
          if (value is BigInt) {
            return value.toString();
          } else if (value is scale.Some || value is scale.NoneOption) {
            return value.toJson();
          }
          return value;
        },
      );
    }
    return toString();
  }
}
