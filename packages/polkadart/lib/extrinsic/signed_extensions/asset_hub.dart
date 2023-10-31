class AssetHubSignedExtensions {
  static String signedExtension(String extension, Map info) {
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

  static String additionalSignedExtension(String extension, Map info) {
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
