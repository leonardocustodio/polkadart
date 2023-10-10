// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Too many subs-accounts.
  tooManySubAccounts('TooManySubAccounts', 0),

  /// Account isn't found.
  notFound('NotFound', 1),

  /// Account isn't named.
  notNamed('NotNamed', 2),

  /// Empty index.
  emptyIndex('EmptyIndex', 3),

  /// Fee is changed.
  feeChanged('FeeChanged', 4),

  /// No identity found.
  noIdentity('NoIdentity', 5),

  /// Sticky judgement.
  stickyJudgement('StickyJudgement', 6),

  /// Judgement given.
  judgementGiven('JudgementGiven', 7),

  /// Invalid judgement.
  invalidJudgement('InvalidJudgement', 8),

  /// The index is invalid.
  invalidIndex('InvalidIndex', 9),

  /// The target is invalid.
  invalidTarget('InvalidTarget', 10),

  /// Too many additional fields.
  tooManyFields('TooManyFields', 11),

  /// Maximum amount of registrars reached. Cannot add any more.
  tooManyRegistrars('TooManyRegistrars', 12),

  /// Account ID is already named.
  alreadyClaimed('AlreadyClaimed', 13),

  /// Sender is not a sub-account.
  notSub('NotSub', 14),

  /// Sub-account isn't owned by sender.
  notOwned('NotOwned', 15),

  /// The provided judgement was for a different identity.
  judgementForDifferentIdentity('JudgementForDifferentIdentity', 16),

  /// Error that occurs when there is an issue paying for judgement.
  judgementPaymentFailed('JudgementPaymentFailed', 17);

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
        return Error.tooManySubAccounts;
      case 1:
        return Error.notFound;
      case 2:
        return Error.notNamed;
      case 3:
        return Error.emptyIndex;
      case 4:
        return Error.feeChanged;
      case 5:
        return Error.noIdentity;
      case 6:
        return Error.stickyJudgement;
      case 7:
        return Error.judgementGiven;
      case 8:
        return Error.invalidJudgement;
      case 9:
        return Error.invalidIndex;
      case 10:
        return Error.invalidTarget;
      case 11:
        return Error.tooManyFields;
      case 12:
        return Error.tooManyRegistrars;
      case 13:
        return Error.alreadyClaimed;
      case 14:
        return Error.notSub;
      case 15:
        return Error.notOwned;
      case 16:
        return Error.judgementForDifferentIdentity;
      case 17:
        return Error.judgementPaymentFailed;
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
