import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:utility/utility.dart';
import 'functions.dart';

Uint8List decodeHex(String value) {
  assertionCheck(value.isHex);
  return Uint8List.fromList(hex.decode(value));
}
