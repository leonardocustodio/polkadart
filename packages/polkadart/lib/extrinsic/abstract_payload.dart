import 'dart:typed_data';

abstract class Payload {
  final Uint8List method; // Call
  final int blockNumber;
  final int eraPeriod; // CheckMortality
  final int nonce; // CheckNonce
  final dynamic tip; // ChargeTransactionPayment
  final int? assetId; // ChargeAssetTxPayment

  const Payload({
    required this.method,
    required this.blockNumber,
    required this.eraPeriod,
    required this.nonce,
    required this.tip,
    this.assetId,
  });

  toEncodedMap(dynamic registry);

  bool usesChargeAssetTxPayment(dynamic registry) {
    if (registry.getSignedExtensionTypes() is Map) {
      return (registry.getSignedExtensionTypes() as Map)
          .containsKey('ChargeAssetTxPayment');
    }
    return (registry.getSignedExtensionTypes() as List)
        .contains('ChargeAssetTxPayment');
  }

  String maybeAssetIdEncoded(dynamic registry) {
    if (usesChargeAssetTxPayment(registry)) {
      // '00' and '01' refer to rust's Option variants 'None' and 'Some'.
      return assetId != null ? '01${assetId!.toRadixString(16)}' : '00';
    } else {
      return '';
    }
  }
}
