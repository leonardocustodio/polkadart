part of balances_calls;

sealed class CallBuilder {
  const CallBuilder();

  /// Encode the call to bytes
  Uint8List encode(final ChainInfo chainInfo);

  /// Get the RuntimeCall representation
  RuntimeCall toRuntimeCall(final ChainInfo chainInfo);
}

/// Helper to look up pallet and call indices
class CallIndicesLookup {
  final ChainInfo chainInfo;
  const CallIndicesLookup(this.chainInfo);

  int getPalletIndex(final String palletName) {
    final pallet = chainInfo.registry.palletByName(palletName);
    if (pallet == null) {
      throw Exception('Pallet not found: $palletName');
    }
    return pallet.index;
  }

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

  ({int palletIndex, int callIndex}) getPalletAndCallIndex({
    required final String palletName,
    required final String callName,
  }) {
    final palletIndex = getPalletIndex(palletName);
    final callIndex = getCallIndex(palletName, callName);
    return (palletIndex: palletIndex, callIndex: callIndex);
  }
}
