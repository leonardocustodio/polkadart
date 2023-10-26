import 'dart:typed_data';

import 'package:ss58/ss58.dart';

import '../polkadart_keyring.dart';

class Pairs {
  final Map<String, KeyPair> _pairs = <String, KeyPair>{};

  void add(KeyPair pair) {
    _pairs[Address.decode(pair.address).pubkey.toList().toString()] = pair;
  }

  KeyPair getByAddress(String address) {
    if (_pairs[address] == null) {
      throw Exception('KeyPair associated with address $address not found.');
    }
    return _pairs[address]!;
  }

  KeyPair getByPublicKey(List<int> publicKey) {
    final address =
        Address(prefix: 42, pubkey: Uint8List.fromList(publicKey)).encode();
    return getByAddress(address);
  }

  ///
  /// Remove a [KeyPair] from the keyring by [address].
  ///
  /// If the [pair] exists, it will be removed.
  void remove(String address) {
    _pairs.remove(address);
  }

  void removeAll() {
    _pairs.clear();
  }

  void removeByPublicKey(List<int> publicKey) {
    final address =
        Address(prefix: 42, pubkey: Uint8List.fromList(publicKey)).encode();
    remove(address);
  }

  List<KeyPair> get all {
    return List<KeyPair>.from(_pairs.values.toList());
  }

  List<List<int>> get publicKeys {
    return all.map((pair) => pair.publicKey.bytes).toList();
  }

  List<String> get addresses {
    return all.map((pair) => pair.address).toList();
  }
}
