import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';

class SubstrateSignedExtensions implements SignedExtensions {
  static final SubstrateSignedExtensions _instance = SubstrateSignedExtensions._internal();

  factory SubstrateSignedExtensions() => _instance;

  SubstrateSignedExtensions._internal();

  @override
  (String, bool) signedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckMortality':
        return (info['era'], true);
      case 'CheckNonce':
        return (info['nonce'], true);
      case 'ChargeTransactionPayment':
        return (info['tip'], true);
      case 'CheckMetadataHash':
        return (info['mode'], true);
      default:
        return ('', false);
    }
  }

  @override
  (String, bool) additionalSignedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckMortality':
        return (info['blockHash'], true);
      case 'CheckSpecVersion':
        return (info['specVersion'], true);
      case 'CheckTxVersion':
        return (info['transactionVersion'], true);
      case 'CheckGenesis':
        return (info['genesisHash'], true);
      case 'CheckMetadataHash':
        return (info['metadataHash'], true);
      default:
        return ('', false);
    }
  }
}
