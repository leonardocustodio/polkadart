part of extrinsic_builder;

/// Abstract base class for building runtime calls
///
/// This allows for both raw bytes and structured call builders
abstract class CallBuilder {
  /// Encode the call to bytes
  Uint8List encode(ChainInfo chainInfo);

  /// Get the RuntimeCall representation
  RuntimeCall toRuntimeCall(ChainInfo chainInfo);
}

/// Raw call data builder - accepts bytes directly
class RawCallBuilder extends CallBuilder {
  final Uint8List callData;

  RawCallBuilder(this.callData);

  /// Create from hex string
  factory RawCallBuilder.fromHex(String hex) {
    final cleanHex = hex.startsWith('0x') ? hex.substring(2) : hex;
    return RawCallBuilder(decodeHex(cleanHex));
  }

  @override
  Uint8List encode(ChainInfo chainInfo) => callData;

  @override
  RuntimeCall toRuntimeCall(ChainInfo chainInfo) {
    final input = Input.fromBytes(callData);
    return chainInfo.callsCodec.decode(input);
  }
}

/// Helper to look up pallet and call indices
class CallIndicesLookup {
  final ChainInfo chainInfo;

  CallIndicesLookup(this.chainInfo);

  /// Get pallet index by name
  int getPalletIndex(String palletName) {
    final pallet = chainInfo.registry.palletByName(palletName);
    if (pallet == null) {
      throw Exception('Pallet not found: $palletName');
    }
    return pallet.index;
  }

  /// Get call index within a pallet
  int getCallIndex(String palletName, String callName) {
    final pallet = chainInfo.registry.palletByName(palletName);
    if (pallet == null) {
      throw Exception('Pallet not found: $palletName');
    }

    if (pallet.calls == null) {
      throw Exception('Pallet $palletName has no calls');
    }

    // Get the call type definition
    final callType = chainInfo.registry.typeById(pallet.calls!.type);
    if (callType.type.typeDef is! TypeDefVariant) {
      throw Exception('Invalid calls type for pallet $palletName');
    }

    final variants = (callType.type.typeDef as TypeDefVariant).variants;

    // Find the variant with matching name
    for (final variant in variants) {
      if (variant.name == callName) {
        return variant.index;
      }
    }

    throw Exception('Call not found: $palletName.$callName');
  }
}
