part of primitives;

/// Health struct returned by the RPC
class Health {
  const Health({
    required this.peers,
    required this.isSyncing,
    required this.shouldHavePeers,
  });

  factory Health.decode(Input input) {
    return codec.decode(input);
  }

  factory Health.fromJson(Map<String, dynamic> json) {
    return Health(
      peers: json['peers'] as int,
      isSyncing: json['isSyncing'] as bool,
      shouldHavePeers: json['shouldHavePeers'] as bool,
    );
  }

  /// Number of connected peers
  final int peers;

  /// Is the node syncing
  final bool isSyncing;

  /// Should this node have any peers
  ///
  /// Might be false for local chains or when running without discovery.
  final bool shouldHavePeers;

  static const $HealthCodec codec = $HealthCodec();

  Uint8List encode() {
    return codec.encode(this);
  }
}

class $HealthCodec with Codec<Health> {
  const $HealthCodec();

  @override
  void encodeTo(
    Health value,
    Output output,
  ) {
    U32Codec.codec.encodeTo(
      value.peers,
      output,
    );
    BoolCodec.codec.encodeTo(
      value.isSyncing,
      output,
    );
    BoolCodec.codec.encodeTo(
      value.shouldHavePeers,
      output,
    );
  }

  @override
  Health decode(Input input) {
    return Health(
      peers: U32Codec.codec.decode(input),
      isSyncing: BoolCodec.codec.decode(input),
      shouldHavePeers: BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Health value) {
    int size = 0;
    size = U32Codec.codec.sizeHint(value.peers);
    size = BoolCodec.codec.sizeHint(value.isSyncing);
    size = BoolCodec.codec.sizeHint(value.shouldHavePeers);
    return size;
  }
}
