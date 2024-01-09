part of sr25519;

abstract class DerivableKey {
  List<int> encode();
  void decode(List<int> bytes);
  ExtendedKey deriveKey(merlin.Transcript t, List<int> chainCodeBytes);
}
