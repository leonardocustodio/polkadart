part of polkadart_keyring;

final PREFIX = utf8.encode('modlpy/utilisuba');

class MultiSig {
  static Uint8List createMultiSigBytes(
      List<Uint8List> signatories, int threshold) {
    if (signatories.isEmpty) {
      throw ArgumentError('No signatories provided.');
    }

    // sort the signatories
    final sortedSignatories = List<Uint8List>.from(signatories)
      ..sort(uint8ListCompare);

    // generate the multi output result
    final result = <int>[];

    // append the PREFIX
    result.addAll(PREFIX);

    // append the length
    result.addAll(
        scale_codec.CompactCodec.codec.encode(sortedSignatories.length));
    for (final who in sortedSignatories) {
      result.addAll(who);
    }
    // append the threshold
    result.addAll(bnToU8a(threshold, bitLength: 16));

    return blake2bDigest(Uint8List.fromList(result));
  }

  static String createMultiSigAddress(List<String> signatories, int threshold,
      {int ss58Format = 42}) {
    return Address(
            prefix: ss58Format,
            pubkey: createMultiSigBytes(
                signatories
                    .map((address) => Address.decode(address).pubkey)
                    .toList(),
                threshold))
        .encode();
  }
}
