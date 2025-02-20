part of multisig;

///
/// Little endian
Uint8List intToUint8List(int? value,
    {int bitLength = -1, bool isLittleEndian = true, bool isNegative = false}) {
  if (value == null) {
    return bitLength == -1 ? Uint8List(1) : Uint8List((bitLength + 7) >> 3);
  }

  BigInt valueBn = BigInt.from(value);

  final int byteLength =
      bitLength == -1 ? (valueBn.bitLength + 7) >> 3 : ((bitLength + 7) >> 3);

  final Uint8List output = Uint8List(byteLength);
  if (isNegative) {
    valueBn = valueBn.toUnsigned(byteLength * 8);
  }

  final List<int> bytes = bigIntToBytes(valueBn, byteLength, isLittleEndian);
  output.setAll(0, bytes);

  return output;
}

///
/// Compare two Uint8List
int uint8ListCompare(Uint8List a, Uint8List b) {
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

///
/// Convert BigInt to bytes
List<int> bigIntToBytes(BigInt number, int size, bool isLittleEndian) {
  final List<int> result = List.filled(size, 0);
  int i = 0;
  while (number > BigInt.zero && i < size) {
    result[isLittleEndian ? i : (size - i - 1)] =
        (number & BigInt.from(0xff)).toInt();
    number = number >> 8;
    i++;
  }
  return result;
}
