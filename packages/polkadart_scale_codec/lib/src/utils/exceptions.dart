part of utils;

///
/// SubtypeNotFoundException
class SubtypeNotFoundException implements Exception {
  const SubtypeNotFoundException();

  @override
  String toString() => 'Vector must have a sub type';
}

///
/// IncompatibleCompactTypeException
class IncompatibleCompactTypeException implements Exception {
  const IncompatibleCompactTypeException(this.type);

  final dynamic type;

  @override
  String toString() => 'Expected Compact type `BigInt or int` but found: $type';
}

///
/// IncompatibleCompactValueException
class IncompatibleCompactValueException implements Exception {
  const IncompatibleCompactValueException(this.value);

  final dynamic value;

  @override
  String toString() => 'Incompatible Compact value: $value';
}

///
/// UnknownEncodeException
class InvalidIntEncodeException implements Exception {
  const InvalidIntEncodeException(this.value);

  final int value;

  @override
  String toString() => 'Invalid UnSigned int to encode: $value';
}

///
/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Unexpected Case.';
}

///
/// EndOfInputException
class EndOfInputException implements Exception {
  const EndOfInputException();

  @override
  String toString() => 'End of Input not reached, Data left for processing.';
}

///
/// EmptyStringException
class EmptyStringException implements Exception {
  const EmptyStringException();

  @override
  String toString() => 'String is empty.';
}

///
/// UnexpectedCodecException
class UnexpectedCodecException implements Exception {
  const UnexpectedCodecException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Unexpected Codec.';
}

///
/// EOFException
class EOFException implements Exception {
  const EOFException();

  @override
  String toString() => 'Unexpected end of file/input exception.';
}

///
/// HexDecodeException
class HexDecodeException implements Exception {
  const HexDecodeException(this.value);

  final String? value;

  @override
  String toString() => 'Invalid hex, unable to decode `$value`.';
}

///
/// HexEncodeException
class HexEncodeException implements Exception {
  const HexEncodeException(this.value);

  final dynamic value;

  @override
  String toString() => 'Invalid bytes, unable to encode `$value`.';
}

///
/// AssertionException
class AssertionException implements Exception {
  const AssertionException([this.message]);

  final String? message;
  @override
  String toString() => message ?? 'Assertion Exception';
}
