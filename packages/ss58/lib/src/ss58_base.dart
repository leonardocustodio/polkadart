import 'dart:typed_data';
import 'package:ss58/src/exceptions.dart';
import 'package:ss58/src/registry.dart';
import 'package:ss58/util/ss58_registry_json.dart' as reg;
import 'package:ss58_codec/ss58_codec.dart';

class Codec {
  final int prefix;

  /// Initialize Codec from the network prefix
  Codec(this.prefix) {
    if (prefix <= 0 || prefix > 16383) {
      throw InvalidPrefixException(prefix);
    }
  }

  /// Initialize Codec from network name
  factory Codec.fromNetwork(String network) {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);
    return Codec(registry.getByNetwork(network).prefix);
  }

  /// Encode the bytes
  String encode(List<int> bytes) {
    return SS58Codec.encode(
        Address(prefix: prefix, bytes: Uint8List.fromList(bytes)));
  }

  /// Decode the Address
  List<int> decode(String encodedAddress) {
    final Address address = SS58Codec.decode(encodedAddress);
    if (address.prefix != prefix) {
      throw InvalidAddressPrefixException(
        prefix: prefix,
        address: address,
        encodedAddress: encodedAddress,
      );
    }
    return address.bytes;
  }
}
