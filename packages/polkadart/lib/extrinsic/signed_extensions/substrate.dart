class SubstrateSignedExtensions {
  static String signedExtension(String extension, Map info) {
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

  static String additionalSignedExtension(String extension, Map info) {
    switch (extension) {
      case 'CheckNonce':
        return info['nonce'];
      case 'ChargeTransactionPayment':
        return info['tip'];
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
