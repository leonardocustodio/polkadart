import 'dart:typed_data';
import './exceptions.dart';
import './registry.dart';
import '../util/ss58_registry_json.dart' as reg;
import './address.dart' show Address;

/// Default class for encoding to/from SS58 substrate
/// address.
///
/// For more informations about substrate address format,
/// check: https://docs.substrate.io/fundamentals/accounts-addresses-keys/.
class Codec {
  final int prefix;

  /// Initialize Codec from the address prefix.
  ///
  /// ```
  /// [Exceptions]
  /// throw InvalidPrefixException: when (prefix < 0 || prefix > 16383)
  /// ```
  Codec(this.prefix) {
    if (prefix < 0 || prefix > 16383) {
      throw InvalidPrefixException(prefix);
    }
  }

  /// Returns a [Registry] instance with all known SS58 account types
  static final registry = Registry.fromMap(reg.jsonRegistryData);

  /// Initialize Codec from address network name.
  factory Codec.fromNetwork(String network) {
    return Codec(registry.getByNetwork(network).prefix);
  }

  /// Encode the bytes
  String encode(List<int> bytes) {
    return Address(prefix: prefix, pubkey: Uint8List.fromList(bytes)).encode();
  }

  /// Decode the [encodedAddress] and return a list of bytes.
  ///
  /// ```
  /// [Exceptions]
  /// throw InvalidAddressPrefixException: when (prefix != decodedAddress.prefix)
  /// ```
  Uint8List decode(String encodedAddress) {
    final Address address = Address.decode(encodedAddress);
    if (address.prefix != prefix) {
      throw InvalidAddressPrefixException(
        prefix: prefix,
        address: address,
        encodedAddress: encodedAddress,
      );
    }
    return address.pubkey;
  }
}
