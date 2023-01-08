part of utils;

///
/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Unexpected Case.';
}

///
/// EOSException
class EOSException implements Exception {
  const EOSException();

  @override
  String toString() => 'Data left for processing.';
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
  String toString() => 'Unexpected end of file/source exception.';
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
