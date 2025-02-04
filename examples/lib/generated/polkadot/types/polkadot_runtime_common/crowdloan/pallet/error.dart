// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The current lease period is more than the first lease period.
  firstPeriodInPast('FirstPeriodInPast', 0),

  /// The first lease period needs to at least be less than 3 `max_value`.
  firstPeriodTooFarInFuture('FirstPeriodTooFarInFuture', 1),

  /// Last lease period must be greater than first lease period.
  lastPeriodBeforeFirstPeriod('LastPeriodBeforeFirstPeriod', 2),

  /// The last lease period cannot be more than 3 periods after the first period.
  lastPeriodTooFarInFuture('LastPeriodTooFarInFuture', 3),

  /// The campaign ends before the current block number. The end must be in the future.
  cannotEndInPast('CannotEndInPast', 4),

  /// The end date for this crowdloan is not sensible.
  endTooFarInFuture('EndTooFarInFuture', 5),

  /// There was an overflow.
  overflow('Overflow', 6),

  /// The contribution was below the minimum, `MinContribution`.
  contributionTooSmall('ContributionTooSmall', 7),

  /// Invalid fund index.
  invalidParaId('InvalidParaId', 8),

  /// Contributions exceed maximum amount.
  capExceeded('CapExceeded', 9),

  /// The contribution period has already ended.
  contributionPeriodOver('ContributionPeriodOver', 10),

  /// The origin of this call is invalid.
  invalidOrigin('InvalidOrigin', 11),

  /// This crowdloan does not correspond to a parachain.
  notParachain('NotParachain', 12),

  /// This parachain lease is still active and retirement cannot yet begin.
  leaseActive('LeaseActive', 13),

  /// This parachain's bid or lease is still active and withdraw cannot yet begin.
  bidOrLeaseActive('BidOrLeaseActive', 14),

  /// The crowdloan has not yet ended.
  fundNotEnded('FundNotEnded', 15),

  /// There are no contributions stored in this crowdloan.
  noContributions('NoContributions', 16),

  /// The crowdloan is not ready to dissolve. Potentially still has a slot or in retirement
  /// period.
  notReadyToDissolve('NotReadyToDissolve', 17),

  /// Invalid signature.
  invalidSignature('InvalidSignature', 18),

  /// The provided memo is too large.
  memoTooLarge('MemoTooLarge', 19),

  /// The fund is already in `NewRaise`
  alreadyInNewRaise('AlreadyInNewRaise', 20),

  /// No contributions allowed during the VRF delay
  vrfDelayInProgress('VrfDelayInProgress', 21),

  /// A lease period has not started yet, due to an offset in the starting block.
  noLeasePeriod('NoLeasePeriod', 22);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.firstPeriodInPast;
      case 1:
        return Error.firstPeriodTooFarInFuture;
      case 2:
        return Error.lastPeriodBeforeFirstPeriod;
      case 3:
        return Error.lastPeriodTooFarInFuture;
      case 4:
        return Error.cannotEndInPast;
      case 5:
        return Error.endTooFarInFuture;
      case 6:
        return Error.overflow;
      case 7:
        return Error.contributionTooSmall;
      case 8:
        return Error.invalidParaId;
      case 9:
        return Error.capExceeded;
      case 10:
        return Error.contributionPeriodOver;
      case 11:
        return Error.invalidOrigin;
      case 12:
        return Error.notParachain;
      case 13:
        return Error.leaseActive;
      case 14:
        return Error.bidOrLeaseActive;
      case 15:
        return Error.fundNotEnded;
      case 16:
        return Error.noContributions;
      case 17:
        return Error.notReadyToDissolve;
      case 18:
        return Error.invalidSignature;
      case 19:
        return Error.memoTooLarge;
      case 20:
        return Error.alreadyInNewRaise;
      case 21:
        return Error.vrfDelayInProgress;
      case 22:
        return Error.noLeasePeriod;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
