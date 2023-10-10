// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
enum Event {
  /// The given member was added; see the transaction for who.
  memberAdded('MemberAdded', 0),

  /// The given member was removed; see the transaction for who.
  memberRemoved('MemberRemoved', 1),

  /// Two members were swapped; see the transaction for who.
  membersSwapped('MembersSwapped', 2),

  /// The membership was reset; see the transaction for who the new set is.
  membersReset('MembersReset', 3),

  /// One of the members' keys changed.
  keyChanged('KeyChanged', 4),

  /// Phantom member, never used.
  dummy('Dummy', 5);

  const Event(
    this.variantName,
    this.codecIndex,
  );

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $EventCodec codec = $EventCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Event.memberAdded;
      case 1:
        return Event.memberRemoved;
      case 2:
        return Event.membersSwapped;
      case 3:
        return Event.membersReset;
      case 4:
        return Event.keyChanged;
      case 5:
        return Event.dummy;
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
