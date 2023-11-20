part of sr25519;

// ExtendedKey consists of a DerivableKey which can be a schnorrkel public or private key
// as well as chain code
class ExtendedKey {
  late final DerivableKey key;
  final List<int> chaincode = List<int>.filled(32, 0);

  ExtendedKey(DerivableKey k, List<int> cc) {
    key = k;
    chaincode.setAll(0, cc);
  }
}
