import 'dart:convert';

import 'package:cryptography/dart.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;

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
