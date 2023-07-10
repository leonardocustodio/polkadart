enum SecretStringError {
  /// The overall format was invalid (e.g. the seed phrase contained symbols).
  invalidFormat('Invalid format',
      'The overall format was invalid (e.g. the seed phrase contained symbols).'),

  /// The seed phrase provided is not a valid BIP39 phrase.
  invalidPhrase('Invalid phrase',
      'The seed phrase provided is not a valid BIP39 phrase.'),

  /// The supplied password was invalid.
  invalidPassword('Invalid password', 'The supplied password was invalid.'),

  /// The seed is invalid (bad content).
  invalidSeed('Invalid seed', 'The seed is invalid (bad content).'),

  /// The seed has an invalid length.
  invalidSeedLength('Invalid seed length', 'The seed has an invalid length.'),

  /// The derivation path was invalid (e.g. contains soft junctions when they are not supported).
  invalidPath('Invalid path',
      'The derivation path was invalid (e.g. contains soft junctions when they are not supported).'),

  /// The entropy byte length was invalid
  invalidEntropy('Invalid Entropy',
      'entropy byte length must be between 16 and 32 and multiple of 4');

  const SecretStringError(this.message, this.description);

  final String message;
  final String description;
}

class SecretStringException implements Exception {
  final SecretStringError cause;
  final String? description;

  factory SecretStringException.invalidFormat([String? description]) =>
      SecretStringException(SecretStringError.invalidFormat, description);
  factory SecretStringException.invalidPhrase([String? description]) =>
      SecretStringException(SecretStringError.invalidPhrase, description);
  factory SecretStringException.invalidPassword([String? description]) =>
      SecretStringException(SecretStringError.invalidPassword, description);
  factory SecretStringException.invalidSeed([String? description]) =>
      SecretStringException(SecretStringError.invalidSeed, description);
  factory SecretStringException.invalidSeedLength([String? description]) =>
      SecretStringException(SecretStringError.invalidSeedLength, description);
  factory SecretStringException.invalidPath([String? description]) =>
      SecretStringException(SecretStringError.invalidPath, description);
  factory SecretStringException.invalidEntropy([String? description]) =>
      SecretStringException(SecretStringError.invalidEntropy, description);

  const SecretStringException(this.cause, [this.description]);

  factory SecretStringException.fromException(Exception e) {
    final message = e.toString();
    if (message.contains('mnemonic: unexpected sentence length')) {
      return SecretStringException.invalidSeedLength();
    } else if (message.contains('does not exist in english')) {
      return SecretStringException.invalidPhrase();
    } else if (message.contains('mnemonic: invalid checksum')) {
      return SecretStringException.invalidSeed();
    }
    return SecretStringException.invalidFormat(message);
  }

  @override
  String toString() {
    if (description != null) {
      return '${cause.message}: $description}';
    }
    return '${cause.message}: ${cause.description}';
  }
}
