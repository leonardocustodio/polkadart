import 'package:ss58_codec/ss58_codec.dart';

/// Exception thrown in [Registry] constructor when `_items`
/// already has an item with the [RegistryItem.prefix].
///
/// Example:
/// ```
/// final item1 = RegistryItem.fromJson({
///      "prefix": 0,
///      "network": "example1",
///      "displayName": "Example 1 display name",
///      "symbols": ["EXA"],
///      "decimals": [10],
///      "standardAccount": "*",
///      "website": ""
///    });
///
/// final item2 = RegistryItem.fromJson({
///      "prefix": 0,
///      "network": "example2",
///      "displayName": "example 2 display name",
///      "symbols": ["EXA"],
///      "decimals": [10],
///      "standardAccount": "*",
///      "website": ""
///    });
///
/// final registry = Registry([item1, item2]);
/// ```
///
class DuplicatePrefixException implements Exception {
  const DuplicatePrefixException(this.prefix);

  final int prefix;

  @override
  String toString() {
    return 'Duplicate prefix: $prefix.';
  }
}

/// Exception thrown in [Registry] constructor when `_items`
/// already has an item with the [RegistryItem.network].
///
/// Example:
/// ```
/// final item1 = RegistryItem.fromJson({
///      "prefix": 1,
///      "network": "example",
///      "displayName": "Example 1 display name",
///      "symbols": ["EXA"],
///      "decimals": [10],
///      "standardAccount": "*",
///      "website": ""
///    });
///
/// final item2 = RegistryItem.fromJson({
///      "prefix": 2,
///      "network": "example",
///      "displayName": "example 2 display name",
///      "symbols": ["EXA"],
///      "decimals": [10],
///      "standardAccount": "*",
///      "website": ""
///    });
///
/// final registry = Registry([item1, item2]);
/// ```
///
class DuplicateNetworkException implements Exception {
  const DuplicateNetworkException(this.network);

  final String network;

  @override
  String toString() {
    return 'Duplicate network: $network.';
  }
}

/// Exception thrown when [Registry] `getByNetwork(String network)` has no match
/// for given [network].
class NoEntryForNetworkException implements Exception {
  const NoEntryForNetworkException(this.network);

  final String network;

  @override
  String toString() {
    return 'No entry for network: $network';
  }
}

/// Exception thrown when [Registry] `getByPrefix(int prefix)` has no match
/// for given [prefix].
class NoEntryForPrefixException implements Exception {
  const NoEntryForPrefixException(this.prefix);

  final int prefix;

  @override
  String toString() {
    return 'No entry for prefix: $prefix';
  }
}

/// Exception thrown in [Codec] `decode(String encodedAddress)` when
/// given [encodedAddress].prefix is different from `Codec.prefix`.
///
/// See an example in `ss58_base_test.dart`.
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

/// Exception thrown when [Codec] `constructor` is called with
///  an invalid prefix.
///
/// Example:
/// ```
/// ... Codec(-1);
/// ... Codec(16384);
/// ```
///
class InvalidPrefixException implements Exception {
  const InvalidPrefixException(this.prefix);

  final int prefix;

  @override
  String toString() {
    return 'Invalid prefix: $prefix.';
  }
}
