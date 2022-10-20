import 'dart:convert';

import 'package:cryptography/dart.dart';
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

  final algorithm = const DartSha256();

  // sinker to which all the hashes will be appended and then (hashed or digested) at last step;
  final sink = algorithm.newHashSink();

  // add content to sinker to be hashed
  sink.add(utf8.encode(content));

  // close the sink to be able to hash/digest
  sink.close();

  return scale.encodeHex(sink.hashSync().bytes);
}
