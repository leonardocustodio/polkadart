part of utils;

/// Asserts if the [value] value is true or not
///
/// Throws `AssertionException` if `false`
void assertionCheck(bool value, [String? msg]) {
  if (!value) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}

///
/// Copies the properties of [from] to [to]
Codec copyProperties(Codec from, Codec to) {
  to.registry = from.registry;
  to.subType = from.subType;
  to.metadata = from.metadata;
  to.bitLength = from.bitLength;
  to.fixedLength = from.fixedLength;
  to.typeString = from.typeString;
  to.valueList = from.valueList;
  return to;
}
