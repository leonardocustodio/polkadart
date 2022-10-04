import 'package:ss58_codec/ss58_codec.dart';

class DuplicatePrefixException implements Exception {
  const DuplicatePrefixException(this.prefix);

  final int prefix;

  @override
  String toString() {
    return 'Duplicate prefix: $prefix.';
  }
}

class DuplicateNetworkException implements Exception {
  const DuplicateNetworkException(this.network);

  final String network;

  @override
  String toString() {
    return 'Duplicate network: $network.';
  }
}

class NoEntryForNetworkException implements Exception {
  const NoEntryForNetworkException(this.network);

  final String network;

  @override
  String toString() {
    return 'No entry for network: $network';
  }
}

class NoEntryForPrefixException implements Exception {
  const NoEntryForPrefixException(this.prefix);

  final int prefix;

  @override
  String toString() {
    return 'No entry for prefix: $prefix';
  }
}

class InvalidAddressPrefixException implements Exception {
  const InvalidAddressPrefixException({
    required this.prefix,
    required this.address,
    required this.encodedAddress,
  });

  final int prefix;
  final Address address;
  final String encodedAddress;

  @override
  String toString() {
    return 'Expected an address with prefix $prefix, but $encodedAddress has prefix ${address.prefix}';
  }
}

class InvalidPrefixException implements Exception {
  const InvalidPrefixException(this.prefix);

  final int prefix;

  @override
  String toString() {
    return 'Invalid prefix: $prefix.';
  }
}
