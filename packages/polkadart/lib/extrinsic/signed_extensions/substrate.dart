import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';

class SubstrateSignedExtensions implements SignedExtensions {
  static final SubstrateSignedExtensions _instance =
      SubstrateSignedExtensions._internal();

  factory SubstrateSignedExtensions() => _instance;

  SubstrateSignedExtensions._internal();

  @override
  String signedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckMortality':
        return info['era'];
      case 'CheckNonce':
        return info['nonce'];
      case 'ChargeTransactionPayment':
        return info['tip'];
      default:
        return '';
    }
  }

  @override
  String additionalSignedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckMortality':
        return info['blockHash'];
      case 'CheckSpecVersion':
        return info['specVersion'];
      case 'CheckTxVersion':
        return info['transactionVersion'];
      case 'CheckGenesis':
        return info['genesisHash'];
      default:
        return '';
    }
  }
}
