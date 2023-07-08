part of primitives;

/// Network Peer information
class PeerInfo<H, N> {
  const PeerInfo({
    required this.peerId,
    required this.roles,
    required this.bestHash,
    required this.bestNumber,
  });

  factory PeerInfo.fromJson(Map<String, dynamic> json) {
    return PeerInfo(
      peerId: json['peerId'] as String,
      roles: json['roles'] as String,
      bestHash: json['bestHash'] as H,
      bestNumber: json['bestNumber'] as N,
    );
  }

  /// Peer ID
  final String peerId;

  /// Roles
  final String roles;

  /// Peer best block hash
  final H bestHash;

  /// Peer best block number
  final N bestNumber;

  Map<String, dynamic> toJson() => {
        'peerId': peerId,
        'roles': roles,
        'bestHash': bestHash,
        'bestNumber': bestNumber,
      };

  @override
  bool operator ==(Object other) =>
      other is PeerInfo &&
      other.peerId == peerId &&
      other.roles == roles &&
      other.bestHash == bestHash &&
      other.bestNumber == bestNumber;

  @override
  int get hashCode => Object.hash(peerId, roles, bestHash, bestNumber);
}

/// PeerInfo Scale Codec
class PeerInfoCodec<H, N> with Codec<PeerInfo<H, N>> {
  final Codec<H> hashCodec;
  final Codec<N> numberCodec;

  const PeerInfoCodec({required this.hashCodec, required this.numberCodec});

  @override
  void encodeTo(
    PeerInfo<H, N> value,
    Output output,
  ) {
    StrCodec.codec.encodeTo(
      value.peerId,
      output,
    );
    StrCodec.codec.encodeTo(
      value.roles,
      output,
    );
    hashCodec.encodeTo(
      value.bestHash,
      output,
    );
    numberCodec.encodeTo(
      value.bestNumber,
      output,
    );
  }

  @override
  PeerInfo<H, N> decode(Input input) {
    return PeerInfo(
      peerId: StrCodec.codec.decode(input),
      roles: StrCodec.codec.decode(input),
      bestHash: hashCodec.decode(input),
      bestNumber: numberCodec.decode(input),
    );
  }

  @override
  int sizeHint(PeerInfo<H, N> value) {
    int size = 0;
    size += StrCodec.codec.sizeHint(value.peerId);
    size += StrCodec.codec.sizeHint(value.roles);
    size += hashCodec.sizeHint(value.bestHash);
    size += numberCodec.sizeHint(value.bestNumber);
    return size;
  }
}
