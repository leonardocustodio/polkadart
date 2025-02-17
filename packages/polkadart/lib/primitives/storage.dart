part of primitives;

/// Storage key.
typedef StorageKey = Uint8List;

/// Storage data associated to a [`StorageKey`].
typedef StorageData = Uint8List;

/// Block hash
typedef BlockHash = Uint8List;

/// ReadProof struct returned by the RPC
class ReadProof {
  /// Block hash used to generate the proof
  final BlockHash at;

  /// A proof used to prove that storage entries are included in the storage trie
  final List<Uint8List> proof;

  ReadProof({required this.at, required this.proof});

  factory ReadProof.fromJson(Map<String, dynamic> json) {
    return ReadProof(
      at: Uint8List.fromList(hex.decode((json['at'] as String).substring(2))),
      proof: (json['proof'] as List)
          .cast<String>()
          .map((proof) => Uint8List.fromList(hex.decode(proof.substring(2))))
          .toList(),
    );
  }
}

class KeyValue {
  final StorageKey key;
  final StorageData? value;

  KeyValue({required this.key, required this.value});

  factory KeyValue.fromJson(List<dynamic> json) {
    final String key = json[0] as String;
    final String? value = json[1] as String?;
    return KeyValue(
      key: Uint8List.fromList(hex.decode(key.substring(2))),
      value: value == null ? null : Uint8List.fromList(hex.decode(value.substring(2))),
    );
  }
}

/// Storage change set
class StorageChangeSet {
  /// Block hash
  final BlockHash block;

  /// A list of changes
  final List<KeyValue> changes;

  StorageChangeSet({required this.block, required this.changes});

  factory StorageChangeSet.fromJson(Map<String, dynamic> json) {
    return StorageChangeSet(
      block: Uint8List.fromList(hex.decode(json['block'].substring(2))),
      changes: (json['changes'] as List)
          .cast<List>()
          .map<KeyValue>((json) => KeyValue.fromJson(json))
          .toList(),
    );
  }
}
