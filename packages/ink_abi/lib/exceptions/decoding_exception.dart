part of ink_abi;

/// Exception thrown when decoding ink! contract data fails
///
/// This occurs when:
/// - Invalid byte data is provided
/// - Decoding from SCALE format fails
/// - Event index is out of bounds
/// - Event signature topic doesn't match
class DecodingException extends InkAbiException {
  /// The selector that was being decoded (if applicable)
  final String? selector;

  /// The event index that was being decoded (if applicable)
  final int? eventIndex;

  /// The signature topic that failed to match (if applicable)
  final String? signatureTopic;

  const DecodingException(
    super.message, {
    this.selector,
    this.eventIndex,
    this.signatureTopic,
    super.context,
  });

  /// Create exception for invalid selector
  factory DecodingException.selectorNotFound(String selector, String type) {
    return DecodingException(
      'Selector $selector not found in $type',
      selector: selector,
      context: {'type': type},
    );
  }

  /// Create exception for output decoding failure
  factory DecodingException.outputDecodingFailed(String selector, String reason) {
    return DecodingException(
      'Failed to decode output for selector $selector: $reason',
      selector: selector,
    );
  }

  /// Create exception for invalid event index
  factory DecodingException.eventIndexOutOfBounds(int index, int maxIndex) {
    return DecodingException(
      'Event index $index out of bounds (max: $maxIndex)',
      eventIndex: index,
      context: {'maxIndex': maxIndex},
    );
  }

  /// Create exception for event signature topic mismatch
  factory DecodingException.signatureTopicNotFound(String topic) {
    return DecodingException('No event found with signature topic: $topic', signatureTopic: topic);
  }

  /// Create exception for event decoding failure
  factory DecodingException.eventDecodingFailed(int eventIndex, String reason) {
    return DecodingException(
      'Failed to decode event at index $eventIndex: $reason',
      eventIndex: eventIndex,
    );
  }

  /// Create exception for insufficient bytes
  factory DecodingException.insufficientBytes(int expected, int actual) {
    return DecodingException(
      'Insufficient bytes for decoding: expected at least $expected, got $actual',
      context: {'expected': expected, 'actual': actual},
    );
  }

  @override
  String toString() {
    final parts = <String>['DecodingException: $message'];

    if (selector != null) {
      parts.add('selector: $selector');
    }
    if (eventIndex != null) {
      parts.add('eventIndex: $eventIndex');
    }
    if (signatureTopic != null) {
      parts.add('signatureTopic: $signatureTopic');
    }
    if (context != null && context!.isNotEmpty) {
      parts.add('context: $context');
    }

    return parts.join(', ');
  }
}

/// Exception thrown during event operations
///
/// This is a specialized decoding exception for event-specific errors.
class InkEventException extends DecodingException {
  const InkEventException(super.message, {super.eventIndex, super.context});

  /// Create exception for topics requirement
  factory InkEventException.topicsRequired() {
    return const InkEventException('Topics required for v5 contracts');
  }

  /// Create exception when event cannot be determined
  factory InkEventException.cannotDetermineEvent(int matchingCount) {
    return InkEventException(
      'Unable to determine event from topics. Found $matchingCount matching events.',
      context: {'matchingEvents': matchingCount},
    );
  }

  @override
  String toString() {
    final parts = <String>['InkEventException: $message'];

    if (eventIndex != null) {
      parts.add('eventIndex: $eventIndex');
    }
    if (context != null && context!.isNotEmpty) {
      parts.add('context: $context');
    }

    return parts.join(', ');
  }
}
