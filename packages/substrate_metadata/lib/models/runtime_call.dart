part of models;

/// Represents a runtime call within an extrinsic
class RuntimeCall {
  /// Name of the pallet
  final String palletName;

  /// Index of the pallet
  final int palletIndex;

  /// Name of the call
  final String callName;

  /// Index of the call within the pallet
  final int callIndex;

  /// Arguments passed to the call
  final Map<String, dynamic> args;

  const RuntimeCall({
    required this.palletName,
    required this.palletIndex,
    required this.callName,
    required this.callIndex,
    required this.args,
  });

  MapEntry<String, Object?> toEncodableJson() {
    return MapEntry<String, Object?>(palletName, MapEntry<String, Object?>(callName, args));
  }

  Map<String, dynamic> toJson() => {
    'pallet': palletName,
    'palletIndex': palletIndex,
    'call': callName,
    'callIndex': callIndex,
    'args': args.toJson(),
  };
}
