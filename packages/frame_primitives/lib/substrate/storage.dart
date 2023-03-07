part of substrate_core;

class StorageHasher<K> {
  final Codec<K> codec;
  final Hasher? hasher;
  final bool concat;

  const StorageHasher(this.codec, this.hasher, this.concat)
      : assert(hasher != null || concat == true);

  const StorageHasher.identity(this.codec)
      : hasher = null,
        concat = true;

  const StorageHasher.blake2b128(this.codec)
      : hasher = Hasher.blake2b128,
        concat = false;

  const StorageHasher.blake2b128Concat(this.codec)
      : hasher = Hasher.blake2b128,
        concat = true;

  const StorageHasher.twoxx64(this.codec)
      : hasher = Hasher.twoxx64,
        concat = false;

  const StorageHasher.twoxx64Concat(this.codec)
      : hasher = Hasher.twoxx64,
        concat = true;

  const StorageHasher.twoxx128(this.codec)
      : hasher = Hasher.twoxx128,
        concat = false;

  const StorageHasher.twoxx128Concat(this.codec)
      : hasher = Hasher.twoxx128,
        concat = true;
  
  const StorageHasher.twoxx256(this.codec)
      : hasher = Hasher.twoxx256,
        concat = false;

  const StorageHasher.twoxx256Concat(this.codec)
      : hasher = Hasher.twoxx256,
        concat = true;

  int size(K key) {
    int size = hasher?.digestSize ?? 0;
    if (concat) {
      size += codec.sizeHint(key);
    }
    return size;
  }

  void hashTo({required K key, required Uint8List output}) {
    final bytes = codec.encode(key);
    final int offset = hasher?.digestSize ?? 0;
    if (hasher != null) {
      hasher!.hashTo(data: bytes, output: output);
    }
    if (concat) {
      for (var i = 0; i < bytes.length; i++) {
        output[i + offset] = bytes[i];
      }
    }
  }

  Uint8List hash(K key) {
    final output = Uint8List(size(key));
    hashTo(key: key, output: output);
    return output;
  }
}

class StorageValue<V> {
  final String prefix;
  final String storage;
  final Codec<V> valueCodec;

  const StorageValue(
      {required this.prefix, required this.storage, required this.valueCodec});

  Uint8List hashedKey() {
    final Uint8List hash = Uint8List(32);
    Hasher.twoxx128.hashTo(
        data: Uint8List.fromList(utf8.encode(prefix)),
        output: hash.buffer.asUint8List(hash.offsetInBytes, 16));
    Hasher.twoxx128.hashTo(
        data: Uint8List.fromList(utf8.encode(storage)),
        output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageMap<K, V> {
  final String prefix;
  final String storage;
  final StorageHasher<K> hasher;
  final Codec<V> valueCodec;

  const StorageMap({
    required this.prefix,
    required this.storage,
    required this.hasher,
    required this.valueCodec,
  });

  Uint8List hashedKeyFor(K key) {
    final Uint8List hash = Uint8List(32 + hasher.size(key));
    Hasher.twoxx128.hashTo(
        data: Uint8List.fromList(utf8.encode(prefix)),
        output: hash.buffer.asUint8List(hash.offsetInBytes, 16));
    Hasher.twoxx128.hashTo(
        data: Uint8List.fromList(utf8.encode(storage)),
        output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16));
    hasher.hashTo(
        key: key, output: hash.buffer.asUint8List(hash.offsetInBytes + 32));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageDoubleMap<K1, K2, V> {
  final String prefix;
  final String storage;
  final StorageHasher<K1> hasher1;
  final StorageHasher<K2> hasher2;
  final Codec<V> valueCodec;

  const StorageDoubleMap({
    required this.prefix,
    required this.storage,
    required this.hasher1,
    required this.hasher2,
    required this.valueCodec,
  });

  Uint8List hashedKeyFor(K1 key1, K2 key2) {
    final Uint8List hash =
        Uint8List(32 + hasher1.size(key1) + hasher2.size(key2));
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(prefix)),
      output: hash.buffer.asUint8List(hash.offsetInBytes, 16),
    );
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(storage)),
      output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16),
    );
    int cursor = hash.offsetInBytes + 32;
    hasher1.hashTo(key: key1, output: hash.buffer.asUint8List(cursor));
    cursor += hasher1.size(key1);
    hasher2.hashTo(key: key2, output: hash.buffer.asUint8List(cursor));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageTripleMap<K1, K2, K3, V> {
  final String prefix;
  final String storage;
  final StorageHasher<K1> hasher1;
  final StorageHasher<K2> hasher2;
  final StorageHasher<K3> hasher3;
  final Codec<V> valueCodec;

  const StorageTripleMap({
    required this.prefix,
    required this.storage,
    required this.hasher1,
    required this.hasher2,
    required this.hasher3,
    required this.valueCodec,
  });

  Uint8List hashedKeyFor(K1 key1, K2 key2, K3 key3) {
    final Uint8List hash = Uint8List(
        32 + hasher1.size(key1) + hasher2.size(key2) + hasher3.size(key3));
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(prefix)),
      output: hash.buffer.asUint8List(hash.offsetInBytes, 16),
    );
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(storage)),
      output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16),
    );
    int cursor = hash.offsetInBytes + 32;
    hasher1.hashTo(key: key1, output: hash.buffer.asUint8List(cursor));
    cursor += hasher1.size(key1);
    hasher2.hashTo(key: key2, output: hash.buffer.asUint8List(cursor));
    cursor += hasher2.size(key2);
    hasher3.hashTo(key: key3, output: hash.buffer.asUint8List(cursor));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageQuadrupleMap<K1, K2, K3, K4, V> {
  final String prefix;
  final String storage;
  final StorageHasher<K1> hasher1;
  final StorageHasher<K2> hasher2;
  final StorageHasher<K3> hasher3;
  final StorageHasher<K4> hasher4;
  final Codec<V> valueCodec;

  const StorageQuadrupleMap({
    required this.prefix,
    required this.storage,
    required this.hasher1,
    required this.hasher2,
    required this.hasher3,
    required this.hasher4,
    required this.valueCodec,
  });

  Uint8List hashedKeyFor(K1 key1, K2 key2, K3 key3, K4 key4) {
    final Uint8List hash = Uint8List(32 +
        hasher1.size(key1) +
        hasher2.size(key2) +
        hasher3.size(key3) +
        hasher4.size(key4));
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(prefix)),
      output: hash.buffer.asUint8List(hash.offsetInBytes, 16),
    );
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(storage)),
      output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16),
    );
    int cursor = hash.offsetInBytes + 32;
    hasher1.hashTo(key: key1, output: hash.buffer.asUint8List(cursor));
    cursor += hasher1.size(key1);
    hasher2.hashTo(key: key2, output: hash.buffer.asUint8List(cursor));
    cursor += hasher2.size(key2);
    hasher3.hashTo(key: key3, output: hash.buffer.asUint8List(cursor));
    cursor += hasher3.size(key3);
    hasher4.hashTo(key: key4, output: hash.buffer.asUint8List(cursor));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageQuintupleMap<K1, K2, K3, K4, K5, V> {
  final String prefix;
  final String storage;
  final StorageHasher<K1> hasher1;
  final StorageHasher<K2> hasher2;
  final StorageHasher<K3> hasher3;
  final StorageHasher<K4> hasher4;
  final StorageHasher<K5> hasher5;
  final Codec<V> valueCodec;

  const StorageQuintupleMap({
    required this.prefix,
    required this.storage,
    required this.hasher1,
    required this.hasher2,
    required this.hasher3,
    required this.hasher4,
    required this.hasher5,
    required this.valueCodec,
  });

  Uint8List hashedKeyFor(K1 key1, K2 key2, K3 key3, K4 key4, K5 key5) {
    final Uint8List hash = Uint8List(32 +
        hasher1.size(key1) +
        hasher2.size(key2) +
        hasher3.size(key3) +
        hasher4.size(key4) +
        hasher5.size(key5));
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(prefix)),
      output: hash.buffer.asUint8List(hash.offsetInBytes, 16),
    );
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(storage)),
      output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16),
    );
    int cursor = hash.offsetInBytes + 32;
    hasher1.hashTo(key: key1, output: hash.buffer.asUint8List(cursor));
    cursor += hasher1.size(key1);
    hasher2.hashTo(key: key2, output: hash.buffer.asUint8List(cursor));
    cursor += hasher2.size(key2);
    hasher3.hashTo(key: key3, output: hash.buffer.asUint8List(cursor));
    cursor += hasher3.size(key3);
    hasher4.hashTo(key: key4, output: hash.buffer.asUint8List(cursor));
    cursor += hasher4.size(key4);
    hasher5.hashTo(key: key5, output: hash.buffer.asUint8List(cursor));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageSextupleMap<K1, K2, K3, K4, K5, K6, V> {
  final String prefix;
  final String storage;
  final StorageHasher<K1> hasher1;
  final StorageHasher<K2> hasher2;
  final StorageHasher<K3> hasher3;
  final StorageHasher<K4> hasher4;
  final StorageHasher<K5> hasher5;
  final StorageHasher<K6> hasher6;
  final Codec<V> valueCodec;

  const StorageSextupleMap({
    required this.prefix,
    required this.storage,
    required this.hasher1,
    required this.hasher2,
    required this.hasher3,
    required this.hasher4,
    required this.hasher5,
    required this.hasher6,
    required this.valueCodec,
  });

  Uint8List hashedKeyFor(K1 key1, K2 key2, K3 key3, K4 key4, K5 key5, K6 key6) {
    final Uint8List hash = Uint8List(32 +
        hasher1.size(key1) +
        hasher2.size(key2) +
        hasher3.size(key3) +
        hasher4.size(key4) +
        hasher5.size(key5) +
        hasher6.size(key6));
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(prefix)),
      output: hash.buffer.asUint8List(hash.offsetInBytes, 16),
    );
    Hasher.twoxx128.hashTo(
      data: Uint8List.fromList(utf8.encode(storage)),
      output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16),
    );
    int cursor = hash.offsetInBytes + 32;
    hasher1.hashTo(key: key1, output: hash.buffer.asUint8List(cursor));
    cursor += hasher1.size(key1);
    hasher2.hashTo(key: key2, output: hash.buffer.asUint8List(cursor));
    cursor += hasher2.size(key2);
    hasher3.hashTo(key: key3, output: hash.buffer.asUint8List(cursor));
    cursor += hasher3.size(key3);
    hasher4.hashTo(key: key4, output: hash.buffer.asUint8List(cursor));
    cursor += hasher4.size(key4);
    hasher5.hashTo(key: key5, output: hash.buffer.asUint8List(cursor));
    cursor += hasher5.size(key5);
    hasher6.hashTo(key: key6, output: hash.buffer.asUint8List(cursor));
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}

class StorageNMap<V> {
  final String prefix;
  final String storage;
  final List<StorageHasher> hashers;
  final Codec<V> valueCodec;

  const StorageNMap(
      {required this.prefix,
      required this.storage,
      required this.hashers,
      required this.valueCodec});

  Uint8List hashedKeyFor(List<dynamic> keys) {
    if (keys.length != hashers.length) {
      throw Exception(
          'Invalid number of keys, expect ${hashers.length}, got ${keys.length}');
    }
    int keySize = 32;
    for (int i = 0; i < keys.length; i++) {
      keySize += hashers[i].size(keys[i]);
    }
    final Uint8List hash = Uint8List(keySize);
    Hasher.twoxx128.hashTo(
        data: Uint8List.fromList(utf8.encode(prefix)),
        output: hash.buffer.asUint8List(hash.offsetInBytes, 16));
    Hasher.twoxx128.hashTo(
        data: Uint8List.fromList(utf8.encode(storage)),
        output: hash.buffer.asUint8List(hash.offsetInBytes + 16, 16));
    int cursor = hash.offsetInBytes + 32;
    for (int i = 0; i < keys.length; i++) {
      hashers[i].hashTo(key: keys[i], output: hash.buffer.asUint8List(cursor));
      cursor += hashers[i].size(keys[i]);
    }
    return hash;
  }

  V decodeValue(Uint8List buffer) {
    return valueCodec.decode(ByteInput(buffer));
  }
}
