import 'dart:typed_data';

import 'package:polkadart/scale_codec.dart';

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

  toEncodedMap(Registry registry);

  bool usesChargeAssetTxPayment(Registry registry) {
    return registry.signedExtensions.containsKey('ChargeAssetTxPayment');
  }

  String maybeAssetIdEncoded(Registry registry) {
    if (usesChargeAssetTxPayment(registry)) {
      // '00' and '01' refer to rust's Option variants 'None' and 'Some'.
      return assetId != null ? '01${assetId!.toRadixString(16)}' : '00';
    } else {
      return '';
    }
  }
}
