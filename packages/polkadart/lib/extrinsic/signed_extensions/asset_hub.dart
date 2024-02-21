import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';

class AssetHubSignedExtensions implements SignedExtensions {
  static final AssetHubSignedExtensions _instance =
      AssetHubSignedExtensions._internal();

  factory AssetHubSignedExtensions() => _instance;

  AssetHubSignedExtensions._internal();

  @override
  (String, bool) signedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckMortality':
        return (info['era'], true);
      case 'CheckNonce':
        return (info['nonce'], true);
      case 'ChargeAssetTxPayment':
        return ('${info['tip']}${info['assetId']}', true);
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
      default:
        return ('', false);
    }
  }
}
