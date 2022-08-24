import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:utility/utility.dart';

Uint8List decodeHex(String value) {
  assert(value.isHex);
  return Uint8List.fromList(hex.decode(value));
}
