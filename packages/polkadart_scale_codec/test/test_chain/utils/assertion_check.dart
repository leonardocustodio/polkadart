void assertionCheck(bool condition, [String? msg]) {
  if (!condition) {
    throw AssertionError(msg ?? 'Assertion Error occured.');
  }
}
