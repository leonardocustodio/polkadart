import 'package:substrate_metadata/substrate_metadata.dart';

/// Helper to look up pallet and call indices from chain metadata.
///
/// This utility class provides convenient methods for resolving pallet
/// and call indices needed when constructing RuntimeCall objects.
///
/// Example:
/// ```dart
/// final lookup = CallIndicesLookup(chainInfo);
/// final indices = lookup.getPalletAndCallIndex(
///   palletName: 'Balances',
///   callName: 'transfer_keep_alive',
/// );
/// print('Pallet: ${indices.palletIndex}, Call: ${indices.callIndex}');
/// ```
class CallIndicesLookup {
  final ChainInfo chainInfo;
  const CallIndicesLookup(this.chainInfo);

  /// Get the pallet index by name.
  ///
  /// Throws [Exception] if the pallet is not found.
  int getPalletIndex(final String palletName) {
    final pallet = chainInfo.registry.palletByName(palletName);
    if (pallet == null) {
      throw Exception('Pallet not found: $palletName');
    }
    return pallet.index;
  }

  /// Get the call index for a specific call within a pallet.
  ///
  /// Throws [Exception] if the pallet or call is not found.
  int getCallIndex(final String palletName, final String callName) {
    final PalletMetadata? pallet = chainInfo.registry.palletByName(palletName);
    if (pallet == null) {
      throw Exception('Pallet not found: $palletName');
    }

    if (pallet.calls == null) {
      throw Exception('Pallet $palletName has no calls');
    }

    final PortableType callType = chainInfo.registry.typeById(pallet.calls!.type);
    if (callType.type.typeDef is! TypeDefVariant) {
      throw Exception('Invalid calls type for pallet $palletName');
    }

    final List<VariantDef> variants = (callType.type.typeDef as TypeDefVariant).variants;

    for (final VariantDef variant in variants) {
      if (variant.name == callName) {
        return variant.index;
      }
    }

    throw Exception('Call not found: $palletName.$callName');
  }

  /// Get both pallet and call indices in a single lookup.
  ///
  /// Returns a record with `palletIndex` and `callIndex`.
  ///
  /// Throws [Exception] if the pallet or call is not found.
  ({int palletIndex, int callIndex}) getPalletAndCallIndex({
    required final String palletName,
    required final String callName,
  }) {
    final palletIndex = getPalletIndex(palletName);
    final callIndex = getCallIndex(palletName, callName);
    return (palletIndex: palletIndex, callIndex: callIndex);
  }
}
