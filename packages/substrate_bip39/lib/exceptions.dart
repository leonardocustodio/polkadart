enum SecretStringError {
  /// The overall format was invalid (e.g. the seed phrase contained symbols).
  invalidFormat(
      'Invalid format', 'The overall format was invalid (e.g. the seed phrase contained symbols).'),

  /// The seed phrase provided is not a valid BIP39 phrase.
  invalidPhrase('Invalid phrase', 'The seed phrase provided is not a valid BIP39 phrase.'),

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
  invalidEntropy(
      'Invalid Entropy', 'entropy byte length must be between 16 and 32 and multiple of 4');

  const SecretStringError(this.message, this.description);

  final String message;
  final String description;
}

class SubstrateBip39Exception implements Exception {
  final SecretStringError cause;
  final String? description;

  factory SubstrateBip39Exception.invalidFormat([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidFormat, description);
  factory SubstrateBip39Exception.invalidPhrase([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidPhrase, description);
  factory SubstrateBip39Exception.invalidPassword([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidPassword, description);
  factory SubstrateBip39Exception.invalidSeed([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidSeed, description);
  factory SubstrateBip39Exception.invalidSeedLength([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidSeedLength, description);
  factory SubstrateBip39Exception.invalidPath([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidPath, description);
  factory SubstrateBip39Exception.invalidEntropy([String? description]) =>
      SubstrateBip39Exception(SecretStringError.invalidEntropy, description);

  const SubstrateBip39Exception(this.cause, [this.description]);

  factory SubstrateBip39Exception.fromException(Exception e) {
    final message = e.toString();
    if (message.contains('mnemonic: unexpected sentence length')) {
      return SubstrateBip39Exception.invalidSeedLength();
    } else if (message.contains('does not exist in english')) {
      return SubstrateBip39Exception.invalidPhrase();
    } else if (message.contains('mnemonic: invalid checksum')) {
      return SubstrateBip39Exception.invalidSeed();
    }
    return SubstrateBip39Exception.invalidFormat(message);
  }

  @override
  String toString() {
    if (description != null) {
      return '${cause.message}: $description}';
    }
    return '${cause.message}: ${cause.description}';
  }
}
