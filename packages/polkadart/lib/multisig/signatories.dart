part of multisig;

class Signatories {
  final List<Signatory> _signatories;
  final Uint8List _multiSigBytes;

  Signatories._(this._signatories, this._multiSigBytes);

  ///
  /// Create a new instance of [Signatories] from a list of addresses and a threshold.
  ///
  /// The [addresses] is a list of addresses of the signatories. Maximum of 100 signatories can be added.
  ///
  /// The [threshold] is the number of signatories required to approve a transaction. Threshold should be at least 2.
  factory Signatories.fromAddresses(List<String> addresses, int threshold) {
    final List<Signatory> signatories =
        addresses.toSet().map((e) => Signatory.fromAddress(e)).toList();

    signatories.sort((a, b) => uint8ListCompare(a.signatoryBytes, b.signatoryBytes));
    return Signatories._(
      signatories,
      _createMultiSigBytes(signatories, threshold),
    );
  }

  List<Uint8List> get sortedSignatoriesBytes =>
      _signatories.map((e) => e.signatoryBytes).toList(growable: false);

  List<String> get sortedSignatoriesAddresses =>
      _signatories.map((e) => e.address).toList(growable: false);

  List<Uint8List> signatoriesExcludeBytes(List<int> signatoryBytes) {
    return sortedSignatoriesBytes
        .where((e) =>
            e.toList(growable: false).toString() !=
            signatoryBytes.toList(growable: false).toString())
        .toList(growable: false);
  }

  List<Uint8List> signatoriesExcludeAddress(String signatoryAddress) {
    return sortedSignatoriesBytes
        .where((e) =>
            e.toList(growable: false).toString() !=
            Address.decode(signatoryAddress).pubkey.toList(growable: false).toString())
        .toList(growable: false);
  }

  Uint8List get mutiSigBytes => Uint8List.fromList(_multiSigBytes);

  static Uint8List _createMultiSigBytes(List<Signatory> sortedSignatories, int threshold) {
    if (sortedSignatories.length < 2 || sortedSignatories.length > 100) {
      throw ArgumentError('The total number of signatories can only be in range of [2, 100].');
    }
    if (threshold > sortedSignatories.length) {
      throw ArgumentError('The threshold should not exceed the number of signatories.');
    }
    if (threshold < 2) {
      throw ArgumentError('The threshold should be at least 2.');
    }

    // generate the multi output result
    final result = <int>[];

    // append the PREFIX
    result.addAll(utf8.encode('modlpy/utilisuba'));

    // append the length
    result.addAll(CompactCodec.codec.encode(sortedSignatories.length));
    for (final who in sortedSignatories) {
      result.addAll(who.signatoryBytes);
    }
    // append the threshold
    result.addAll(intToUint8List(threshold, bitLength: 16));

    return Hasher.blake2b256.hash(Uint8List.fromList(result));
  }
}
