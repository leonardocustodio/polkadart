part of polkadart_keyring;

final PREFIX = utf8.encode('modlpy/utilisuba');

class MultiSig {
  final int threshold;
  static final List<Uint8List> _who = <Uint8List>[];

  const MultiSig(this.threshold);

  void addBytes(Uint8List who) {
    _who.add(who);
  }

  void addBytesList(List<Uint8List> whoList) {
    _who.addAll(whoList);
  }

  Uint8List generateMultiSig() {
    if (_who.isEmpty) {
      throw Exception(
          'No signatories added. Add using addBytes(...) or addBytesList(...)');
    }

    /// sort the signatories
    _who.sort(u8aCmp);

    /// generate the multi output result
    final result = <int>[];

    // append the PREFIX
    result.addAll(PREFIX);

    // append the length
    result.add(_who.length);
    for (final who in _who) {
      result.addAll(who);
    }
    // append the threshold
    result.add(threshold);

    return blake2bDigest(Uint8List.fromList(result));
  }
}

int u8aCmp(Uint8List a, Uint8List b) {
  int i = 0;
  while (true) {
    final overA = i >= a.length;
    final overB = i >= b.length;
    if (overA && overB) {
      // both ends reached
      return 0;
    } else if (overA) {
      // a has no more data, b has data
      return -1;
    } else if (overB) {
      // b has no more data, a has data
      return 1;
    } else if (a[i] != b[i]) {
      // the number in this index doesn't match
      // (we don't use u8aa[i] - u8ab[i] since that doesn't match with localeCompare)
      return a[i] > b[i] ? 1 : -1;
    }
    i++;
  }
}
