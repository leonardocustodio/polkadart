# Polkadart Keyring

Polkadart Keyring is a manager for ed25519-based key pairs in the keyring. It provides a convenient interface to manage ed25519-based key pairs, allowing you to create key pairs from BIP39 mnemonics, add them to the keyring, retrieve key pairs by address or public key, and perform various operations on them.

## Installation

To use Polkadart Keyring in your Dart project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  polkadart_keyring: ^1.0.0
```

## Usage

### Creating KeyPairs from Mnemonic

You can create a new [KeyPair] from a BIP39 mnemonic and optionally add it to the keyring. Here's an example:

```dart
final keyring = Keyring();
final mnemonic =
    'moral movie very draw assault whisper awful rebuild speed purity repeat card';
final keyPair = await keyring.createKeyPairFromMnemonic(mnemonic);
```

### Adding and Retrieving KeyPairs

You can add and retrieve key pairs using the keyring:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));
final keyPair2 = KeyPair.fromSeed(Uint8List.fromList(hex.decode(
    '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

// Add keyPair1 to keyring
keyring.add(keyPair1);

final address1 = keyPair1.address;
final address2 = keyPair2.address;

// Add keyPair2 to keyring
keyring.add(keyPair2);

final addresses = keyring.addresses;
```

### Retrieving KeyPairs by PublicKey

You can retrieve key pairs by their public keys:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));

final publicKey1 = keyPair1.publicKey.bytes;

// Add keyPair1 to key
keyring.add(keyPair1);

final keyPair = keyring.getByPublicKey(publicKey1);

final nonExistentKeyPair = keyring.getByPublicKey([1, 2, 3]);
```

### Removing KeyPairs

You can remove key pairs from the keyring:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));

// Add keyPair1 and keyPair2 to keyring
keyring.add(keyPair1);
keyring.add(keyPair2);

final address1 = keyPair1.address;
keyring.remove(address1);

final nonExistentKeyPair = keyring.getByAddress(address1);
```

### Encoding and Decoding Addresses

You can encode and decode addresses:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));

final address = keyPair1.address;
final publicKey = keyPair1.publicKey.bytes;

// Encode the public key to an address
final encodedAddress = keyring.encodeAddress(publicKey);

final isAddressCorrect = encodedAddress == address;

// Decode the address to a public key
final decodedPublicKey = keyring.decodeAddress(address);

final isPublicKeyCorrect = decodedPublicKey == publicKey;
```

### Setting and Getting SS58 Address Format

You can set and get the SS58 address format used by the keyring:

```dart
final keyring = Keyring();

keyring.ss58Format = 42;

print(keyring.ss58Format);
```

### Getting All Public Keys

You can retrieve all public keys in the keyring:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));
final keyPair2 = KeyPair.fromSeed(Uint8List.fromList(hex.decode(
    '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

keyring
  ..add(keyPair1)
  ..add(keyPair2);

final publicKeys = keyring.publicKeys; // [ List<int>, List<int> ]
```

### Getting All Addresses

You can retrieve all addresses in the keyring:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));
final keyPair2 = KeyPair.fromSeed(Uint8List.fromList(hex.decode(
    '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

keyring
  ..add(keyPair1)
  ..add(keyPair2);
final addresses = keyring.addresses;
```

### Getting All KeyPairs

You can retrieve all key pairs in the keyring:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits));
final keyPair2 = KeyPair.fromSeed(Uint8List.fromList(hex.decode(
    '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

keyring
  ..add(keyPair1)
  ..add(keyPair2);

final allKeyPairs = keyring.all; // [ KeyPair, KeyPair ]
```

### Removing All KeyPairs

You can remove all key pairs from the keyring:

```dart
final keyring = Keyring();
final keyPair1 = KeyPair.fromSeed(
    Uint8List

.fromList('12345678901234567890123456789012'.codeUnits));
final keyPair2 = KeyPair.fromSeed(Uint8List.fromList(hex.decode(
    '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

keyring
  ..add(keyPair1)
  ..add(keyPair2);

keyring.clear();

final isKeyringEmpty = keyring.all.isEmpty;
```

### Signing and Verifying

You can sign and verify messages:

```dart
final keyring = Keyring();
final keyPair2 = KeyPair.fromSeed(Uint8List.fromList(hex.decode(
    '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

keyring.add(keyPair2);

final kp = keyring.getByPublicKey(keyPair2.publicKey.bytes);

final signature = kp.sign(message);

final isVerified = kp.verify(message, signature);
```
