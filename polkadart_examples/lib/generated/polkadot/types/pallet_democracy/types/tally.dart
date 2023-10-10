// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class Tally {
  const Tally({
    required this.ayes,
    required this.nays,
    required this.turnout,
  });

  factory Tally.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt ayes;

  /// Balance
  final BigInt nays;

  /// Balance
  final BigInt turnout;

  static const $TallyCodec codec = $TallyCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'ayes': ayes,
        'nays': nays,
        'turnout': turnout,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Tally &&
          other.ayes == ayes &&
          other.nays == nays &&
          other.turnout == turnout;

  @override
  int get hashCode => Object.hash(
        ayes,
        nays,
        turnout,
      );
}

class $TallyCodec with _i1.Codec<Tally> {
  const $TallyCodec();

  @override
  void encodeTo(
    Tally obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.ayes,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.nays,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.turnout,
      output,
    );
  }

  @override
  Tally decode(_i1.Input input) {
    return Tally(
      ayes: _i1.U128Codec.codec.decode(input),
      nays: _i1.U128Codec.codec.decode(input),
      turnout: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Tally obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.ayes);
    size = size + _i1.U128Codec.codec.sizeHint(obj.nays);
    size = size + _i1.U128Codec.codec.sizeHint(obj.turnout);
    return size;
  }
}
