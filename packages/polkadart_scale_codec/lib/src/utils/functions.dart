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
/* Codec copyProperties(Codec from, Codec to) {
  to.bitLength = from.bitLength;
  to.fixedLength = from.fixedLength;
  to.metadata = from.metadata;
  to.registry = from.registry;
  to.subType = from.subType;
  to.typeString = from.typeString;
  to.typeStruct = from.typeStruct;
  to.valueList = from.valueList;
  return to;
}
 */
