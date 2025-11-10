part of extrinsic_builder;

/// Base class for Balances pallet calls
abstract class BalancesCallBuilder extends CallBuilder {
  static const String palletName = 'Balances';

  String get callName;
  Map<String, dynamic> buildArgs();

  @override
  RuntimeCall toRuntimeCall(ChainInfo chainInfo) {
    final lookup = CallIndicesLookup(chainInfo);

    return RuntimeCall(
      palletName: palletName,
      palletIndex: lookup.getPalletIndex(palletName),
      callName: callName,
      callIndex: lookup.getCallIndex(palletName, callName),
      args: buildArgs(),
    );
  }

  @override
  Uint8List encode(ChainInfo chainInfo) {
    final call = toRuntimeCall(chainInfo);
    final output = ByteOutput();
    chainInfo.callsCodec.encodeTo(call, output);
    return output.toBytes();
  }
}

/// Balances.transfer_allow_death call (commonly just "transfer")
class BalancesTransfer extends BalancesCallBuilder {
  final MultiAddress dest; // Will be encoded as MultiAddress
  final BigInt amount;

  BalancesTransfer({
    required this.dest,
    required this.amount,
  });

  /// Create with AccountId32 as destination
  factory BalancesTransfer.toAccountId({
    required Uint8List receiverAccountId,
    required BigInt amount,
  }) {
    // MultiAddress::Id variant (index 0)
    return BalancesTransfer(
      dest: MultiAddress.id(receiverAccountId),
      amount: amount,
    );
  }

  @override
  String get callName => 'transfer';

  @override
  Map<String, dynamic> buildArgs() => {
        'dest': dest.toJson(),
        'value': amount,
      };
}

/// Balances.transfer_keep_alive call
class BalancesTransferKeepAlive extends BalancesCallBuilder {
  final MultiAddress dest;
  final BigInt amount;

  BalancesTransferKeepAlive({
    required this.dest,
    required this.amount,
  });

  factory BalancesTransferKeepAlive.toAccountId({
    required Uint8List receiverAccountId,
    required BigInt amount,
  }) {
    return BalancesTransferKeepAlive(
      dest: MultiAddress.id(receiverAccountId),
      amount: amount,
    );
  }

  @override
  String get callName => 'transfer_keep_alive';

  @override
  Map<String, dynamic> buildArgs() => {
        'dest': dest.toJson(),
        'value': amount,
      };
}

/// Balances.transfer_all call
class BalancesTransferAll extends BalancesCallBuilder {
  final MultiAddress dest;
  final bool keepAlive;

  BalancesTransferAll({
    required this.dest,
    required this.keepAlive,
  });

  factory BalancesTransferAll.toAccountId({
    required Uint8List receiverAccountId,
    required bool keepAlive,
  }) {
    return BalancesTransferAll(
      dest: MultiAddress.id(receiverAccountId),
      keepAlive: keepAlive,
    );
  }

  @override
  String get callName => 'transfer_all';

  @override
  Map<String, dynamic> buildArgs() => {
        'dest': dest.toJson(),
        'keep_alive': keepAlive,
      };
}

/// Balances.force_transfer call (requires root/sudo)
class BalancesForceTransfer extends BalancesCallBuilder {
  final dynamic source;
  final MultiAddress dest;
  final BigInt amount;

  BalancesForceTransfer({
    required this.source,
    required this.dest,
    required this.amount,
  });

  @override
  String get callName => 'force_transfer';

  @override
  Map<String, dynamic> buildArgs() => {
        'source': source,
        'dest': dest.toJson(),
        'value': amount,
      };
}

/// Balances.set_balance_deprecated call (old chains)
class BalancesSetBalanceDeprecated extends BalancesCallBuilder {
  final dynamic who;
  final BigInt newFree;
  final BigInt newReserved;

  BalancesSetBalanceDeprecated({
    required this.who,
    required this.newFree,
    required this.newReserved,
  });

  @override
  String get callName => 'set_balance_deprecated';

  @override
  Map<String, dynamic> buildArgs() => {
        'who': who,
        'new_free': newFree,
        'new_reserved': newReserved,
      };
}

/// Balances.force_set_balance call (newer chains)
class BalancesForceSetBalance extends BalancesCallBuilder {
  final dynamic who;
  final BigInt newFree;

  BalancesForceSetBalance({
    required this.who,
    required this.newFree,
  });

  @override
  String get callName => 'force_set_balance';

  @override
  Map<String, dynamic> buildArgs() => {
        'who': who,
        'new_free': newFree,
      };
}
