///
/// Invalid Prefix Exception
class InvalidPrefixException implements Exception {
  const InvalidPrefixException([this.prefix]);

  /// Prefix of Network in Registry Items list;
  final int? prefix;

  @override
  String toString() {
    return 'Invalid SS58 prefix byte${prefix == null ? '' : ': $prefix'}.';
  }
}

///
/// Invalid Prefix Exception
class InvalidCheckSumException implements Exception {
  const InvalidCheckSumException();

  @override
  String toString() {
    return 'Invalid checksum';
  }
}

///
/// Bad Length Exception
class BadAddressLengthException implements Exception {
  const BadAddressLengthException([this.address]);

  /// Address which is of improper length;
  final String? address;

  @override
  String toString() {
    return 'Bad Length Address${address == null ? '' : ': $address'}.';
  }
}
