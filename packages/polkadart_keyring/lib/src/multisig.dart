part of polkadart_keyring;

final PREFIX = utf8.encode('modlpy/utilisuba');

class MultiSig {
  static Uint8List createMultiSigBytes(
      List<Uint8List> signatories, int threshold) {
    if (signatories.length < 2 || signatories.length > 100) {
      throw ArgumentError('The signatories should be 2 to 100.');
    }
    if (threshold > signatories.length) {
      throw ArgumentError(
          'The threshold should not exceed the number of signatories.');
    }
    if (threshold < 2) {
      throw ArgumentError('The threshold should be at least 2.');
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

  static List<Uint8List> sortAddressesExcludeMe(
      List<Uint8List> addresses, Uint8List me) {
    final sorted = List<Uint8List>.from(addresses);
    sorted.removeWhere(
        (address) => address.toList().toString() == me.toList().toString());
    sorted.sort(uint8ListCompare);
    return sorted;
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
