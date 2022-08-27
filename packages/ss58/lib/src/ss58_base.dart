import 'dart:typed_data';
import 'package:ss58/src/registry.dart';
import 'package:ss58/util/ss58_registry_json.dart' as reg;
import 'package:ss58_codec/ss58_codec.dart';

final registry = Registry.fromJsonString(reg.jsonRegistryData);

class Codec {
  int prefix = -1;

  /// Initialize Codec from the network prefix
  Codec(this.prefix) : assert(prefix >= 0 && prefix < 16384, 'invalid prefix');

  /// Initialize Codec from network name
  Codec.fromNetwork(String network) {
    Codec(registry.getByNetwork(network).prefix);
  }

  /// Encode the bytes
  String encode(List<int> bytes) {
    return SS58Codec.encode(
        Address(prefix: prefix, bytes: Uint8List.fromList(bytes)));
  }

  /// Decode the Address
  List<int> decode(String s) {
    var address = SS58Codec.decode(s);
    if (address.prefix != prefix) {
      throw Exception(
          'Expected an address with prefix $prefix, but $s has prefix ${address.prefix}');
    }
    return address.bytes;
  }
}
