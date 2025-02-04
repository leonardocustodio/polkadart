// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i2;
import 'unlock_chunk.dart' as _i3;

class StakingLedger {
  const StakingLedger({
    required this.stash,
    required this.total,
    required this.active,
    required this.unlocking,
    required this.legacyClaimedRewards,
  });

  factory StakingLedger.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// T::AccountId
  final _i2.AccountId32 stash;

  /// BalanceOf<T>
  final BigInt total;

  /// BalanceOf<T>
  final BigInt active;

  /// BoundedVec<UnlockChunk<BalanceOf<T>>, T::MaxUnlockingChunks>
  final List<_i3.UnlockChunk> unlocking;

  /// BoundedVec<EraIndex, T::HistoryDepth>
  final List<int> legacyClaimedRewards;

  static const $StakingLedgerCodec codec = $StakingLedgerCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'stash': stash.toList(),
        'total': total,
        'active': active,
        'unlocking': unlocking.map((value) => value.toJson()).toList(),
        'legacyClaimedRewards': legacyClaimedRewards,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is StakingLedger &&
          _i5.listsEqual(
            other.stash,
            stash,
          ) &&
          other.total == total &&
          other.active == active &&
          _i5.listsEqual(
            other.unlocking,
            unlocking,
          ) &&
          _i5.listsEqual(
            other.legacyClaimedRewards,
            legacyClaimedRewards,
          );

  @override
  int get hashCode => Object.hash(
        stash,
        total,
        active,
        unlocking,
        legacyClaimedRewards,
      );
}

class $StakingLedgerCodec with _i1.Codec<StakingLedger> {
  const $StakingLedgerCodec();

  @override
  void encodeTo(
    StakingLedger obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.stash,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.total,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.active,
      output,
    );
    const _i1.SequenceCodec<_i3.UnlockChunk>(_i3.UnlockChunk.codec).encodeTo(
      obj.unlocking,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      obj.legacyClaimedRewards,
      output,
    );
  }

  @override
  StakingLedger decode(_i1.Input input) {
    return StakingLedger(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      total: _i1.CompactBigIntCodec.codec.decode(input),
      active: _i1.CompactBigIntCodec.codec.decode(input),
      unlocking: const _i1.SequenceCodec<_i3.UnlockChunk>(_i3.UnlockChunk.codec)
          .decode(input),
      legacyClaimedRewards: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(StakingLedger obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.stash);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.total);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.active);
    size = size +
        const _i1.SequenceCodec<_i3.UnlockChunk>(_i3.UnlockChunk.codec)
            .sizeHint(obj.unlocking);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(obj.legacyClaimedRewards);
    return size;
  }
}
