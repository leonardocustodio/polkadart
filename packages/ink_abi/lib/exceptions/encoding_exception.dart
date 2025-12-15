part of ink_abi;

/// Exception thrown when encoding ink! contract data fails
///
/// This occurs when:
/// - Invalid argument types are provided
/// - Encoding to SCALE format fails
/// - Selector is invalid or not found
class EncodingException extends InkAbiException {
  /// The selector that was being encoded (if applicable)
  final String? selector;

  /// The argument name that failed to encode (if applicable)
  final String? argumentName;

  /// The expected type for the argument
  final String? expectedType;

  /// The actual value that failed to encode
  final dynamic actualValue;

  const EncodingException(
    super.message, {
    this.selector,
    this.argumentName,
    this.expectedType,
    this.actualValue,
    super.context,
  });

  /// Create exception for invalid selector
  factory EncodingException.selectorNotFound(String selector, String type) {
    return EncodingException(
      'Selector $selector not found in $type',
      selector: selector,
      context: {'type': type},
    );
  }

  /// Create exception for argument encoding failure
  factory EncodingException.argumentEncodingFailed(
    String argumentName,
    String expectedType,
    dynamic actualValue,
    String reason,
  ) {
    return EncodingException(
      'Failed to encode argument "$argumentName": $reason',
      argumentName: argumentName,
      expectedType: expectedType,
      actualValue: actualValue,
    );
  }

  /// Create exception for invalid argument count
  factory EncodingException.argumentCountMismatch(int expected, int actual, String selector) {
    return EncodingException(
      'Expected $expected arguments but got $actual',
      selector: selector,
      context: {'expected': expected, 'actual': actual},
    );
  }

  @override
  String toString() {
    final parts = <String>['EncodingException: $message'];

    if (selector != null) {
      parts.add('selector: $selector');
    }
    if (argumentName != null) {
      parts.add('argument: $argumentName');
    }
    if (expectedType != null) {
      parts.add('expectedType: $expectedType');
    }
    if (actualValue != null) {
      parts.add('actualValue: $actualValue');
    }
    if (context != null && context!.isNotEmpty) {
      parts.add('context: $context');
    }

    return parts.join(', ');
  }
}
