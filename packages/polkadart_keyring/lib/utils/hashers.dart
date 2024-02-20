part of polkadart_keyring;

Uint8List blake2bDigest(Uint8List data) {
  final digest = Blake2bDigest(digestSize: 32);
  digest.update(data, 0, data.length);
  final output = Uint8List(32);
  digest.doFinal(output, 0);
  return output;
}
