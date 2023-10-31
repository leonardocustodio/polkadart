class AssetHubSignedExtensions {
  static String signedExtensionPayload(String extension, Map info) {
    switch (extension) {
      case 'CheckSpecVersion':
        return info['specVersion'];
      case 'CheckTxVersion':
        return info['transactionVersion'];
      case 'CheckGenesis':
        return info['genesisHash'];
      case 'CheckMortality':
        return info['era'];
      case 'CheckNonce':
        return info['nonce'];
      case 'ChargeAssetTxPayment':
        return info['tip'];
      default:
        return '';
    }
  }
}
