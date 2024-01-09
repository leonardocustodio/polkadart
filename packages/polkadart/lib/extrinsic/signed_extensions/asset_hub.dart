import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';

class AssetHubSignedExtensions implements SignedExtensions {
  static final AssetHubSignedExtensions _instance =
      AssetHubSignedExtensions._internal();

  factory AssetHubSignedExtensions() => _instance;

  AssetHubSignedExtensions._internal();

  @override
  String signedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckMortality':
        return info['era'];
      case 'CheckNonce':
        return info['nonce'];
      case 'ChargeAssetTxPayment':
        return '${info['tip']}${info['assetId']}';
      default:
        return '';
    }
  }

  @override
  String additionalSignedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckNonce':
        return info['nonce'];
      case 'ChargeAssetTxPayment':
        return '${info['tip']}${info['assetId']}';
      case 'CheckSpecVersion':
        return info['specVersion'];
      case 'CheckTxVersion':
        return info['transactionVersion'];
      case 'CheckGenesis':
        return info['genesisHash'];
      case 'CheckMortality':
        return info['blockHash'];
      default:
        return '';
    }
  }
}
