// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class Delegations {
  const Delegations({
    required this.votes,
    required this.capital,
  });

  factory Delegations.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt votes;

  /// Balance
  final BigInt capital;

  static const $DelegationsCodec codec = $DelegationsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'votes': votes,
        'capital': capital,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Delegations && other.votes == votes && other.capital == capital;

  @override
  int get hashCode => Object.hash(
        votes,
        capital,
      );
}

class $DelegationsCodec with _i1.Codec<Delegations> {
  const $DelegationsCodec();

  @override
  void encodeTo(
    Delegations obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.votes,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.capital,
      output,
    );
  }

  @override
  Delegations decode(_i1.Input input) {
    return Delegations(
      votes: _i1.U128Codec.codec.decode(input),
      capital: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Delegations obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.votes);
    size = size + _i1.U128Codec.codec.sizeHint(obj.capital);
    return size;
  }
}
