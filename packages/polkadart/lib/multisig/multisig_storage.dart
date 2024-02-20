part of multisig;

class MultisigStorage {
  final TimePoint timePoint;
  final BigInt deposit;
  final Uint8List depositor;
  final List<Uint8List> approvals;

  const MultisigStorage({
    required this.timePoint,
    required this.deposit,
    required this.depositor,
    required this.approvals,
  });

  static final codec = CompositeCodec(
    {
      'when': CompositeCodec({
        'height': U32Codec.codec,
        'index': U32Codec.codec,
      }),
      'deposit': U128Codec.codec,
      'depositor': ArrayCodec(U8Codec.codec, 32),
      'approvals': SequenceCodec(ArrayCodec(U8Codec.codec, 32)),
    },
  );

  bool isAlreadyApprovedBy(Uint8List address) {
    return approvals.any((element) => element.toHex() == address.toHex());
  }

  bool isOnlyOneApprovalLeft(int signatoriesLength) {
    return approvals.length == signatoriesLength - 1;
  }

  bool isOwner(Uint8List address) {
    return depositor.toHex() == address.toHex();
  }

  bool isApprovedByAll(int signatoriesLength) {
    return approvals.length >= signatoriesLength;
  }

  static MultisigStorage decodeFrom(Input input) {
    final decoded = codec.decode(input);
    return MultisigStorage.fromMap(decoded);
  }

  factory MultisigStorage.fromMap(Map<String, dynamic> map) {
    return MultisigStorage(
      timePoint: TimePoint(
        index: map['when']['index'],
        height: map['when']['height'],
      ),
      deposit: map['deposit'],
      depositor: Uint8List.fromList(map['depositor']),
      // approvals = List<List<int>>
      approvals: (map['approvals'] as List<List<int>>)
          .map((e) => Uint8List.fromList(e))
          .toList(),
    );
  }

  ///
  /// Make Multisig Storage Key
  static Uint8List createMultisigStorageKey(
      Uint8List multiSigAddressBytes, Uint8List callHashReceiver) {
    final multisigModuleHash = Hasher.twoxx128.hashString('Multisig');
    final multisigStorageHash = Hasher.twoxx128.hashString('Multisigs');
    final multisigAddressHash = Hasher.twoxx64.hash(multiSigAddressBytes);
    final multisigCallHash = Hasher.blake2b128.hash(callHashReceiver);

    final multisigStorageKey = multisigModuleHash +
        multisigStorageHash +
        multisigAddressHash +
        multiSigAddressBytes +
        multisigCallHash +
        callHashReceiver;

    return Uint8List.fromList(multisigStorageKey);
  }
}
