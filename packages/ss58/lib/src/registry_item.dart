import 'package:equatable/equatable.dart';

// RegistryItem for storing registry information
//
// This class can be easily compared for equality.
class RegistryItem extends Equatable {
  /// The address prefix (ss58 address type).
  //
  /// Must be unique across registry.
  final int prefix;

  /// Unique identifier for the network that will use this prefix
  //
  /// No spaces allowed.
  final String network;

  ///
  /// The name of the network that will use this prefix, in a format friendly for display.
  final String displayName;

  ///
  /// Array of symbols of any tokens the chain uses, usually 2-5 characters.
  //
  /// Most chains will only have one.
  /// Chains that have multiple instances of the Balances pallet should order the array by instance.
  final List<String> _symbols = <String>[];

  ///
  /// Array of integers representing the number of decimals that represent a single unit to the end user.
  //
  /// Must be same length as `symbols` to represent each token's denomination.
  final List<int> _decimals = <int>[];

  ///
  /// Signing curve for standard account.
  //
  /// Substrate supports ed25519, sr25519, and secp256k1.
  final String? standardAccount;

  ///
  /// A website or GitHub repo associated with the network.
  final String? website;

  ///
  /// Private constructor of RegistryItem Model
  RegistryItem._({
    required this.prefix,
    required this.network,
    required this.displayName,
    List<int> decimalsValue = const <int>[],
    List<String> symbolsValue = const <String>[],
    this.standardAccount,
    this.website,
  }) {
    _decimals.addAll(decimalsValue);
    _symbols.addAll(symbolsValue);
  }

  /// Initialize Registry Item from the Json
  factory RegistryItem.fromJson(Map<String, dynamic> json) {
    return RegistryItem._(
      prefix: json['prefix'],
      network: json['network'],
      displayName: json['displayName'],
      symbolsValue: (json['symbols'] as List<dynamic>).cast<String>(),
      decimalsValue: (json['decimals'] as List<dynamic>).cast<int>(),
      standardAccount: json['standardAccount'],
      website: json['website'],
    );
  }

  /// returns Json of the Registry
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'prefix': prefix,
      'network': network,
      'displayName': displayName,
      'symbols': _symbols,
      'decimals': _decimals,
      'standardAccount': standardAccount,
      'website': website,
    };
  }

  /// Creating a new object as a copy of decimals to make it [unmodifiable]
  List<int> get decimals => List<int>.from(_decimals);

  /// Creating a new object as a copy of symbols to make it [unmodifiable]
  List<String> get symbols => List<String>.from(_symbols);

  /// Used to match and calculate hashcode with equality
  @override
  List<Object?> get props => [
        prefix,
        network,
        displayName,
        _symbols,
        _decimals,
        standardAccount,
        website,
      ];
}
