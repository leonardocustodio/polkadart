part of utils;

///
/// AssertionException
class AssertionException implements Exception {
  const AssertionException([this.message]);

  final String? message;
  @override
  String toString() => message ?? 'Assertion Exception';
}

///
/// EOFException
class EOFException implements Exception {
  const EOFException();

  @override
  String toString() => 'EOF Exception';
}

///
/// HexException
class HexException implements Exception {
  const HexException(this.message);

  final String message;
  @override
  String toString() => message;
}

///
/// OutOfBoundsException
class OutOfBoundsException implements Exception {
  const OutOfBoundsException();

  @override
  String toString() => 'Out of Bounds Exception';
}

///
/// OptionException
class OptionException implements Exception {
  const OptionException(this.message);

  final String message;
  @override
  String toString() => message;
}