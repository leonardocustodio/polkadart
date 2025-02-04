// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'casting.dart' as _i3;
import 'delegating.dart' as _i4;

abstract class Voting {
  const Voting();

  factory Voting.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VotingCodec codec = $VotingCodec();

  static const $Voting values = $Voting();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Voting {
  const $Voting();

  Casting casting(_i3.Casting value0) {
    return Casting(value0);
  }

  Delegating delegating(_i4.Delegating value0) {
    return Delegating(value0);
  }
}

class $VotingCodec with _i1.Codec<Voting> {
  const $VotingCodec();

  @override
  Voting decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Casting._decode(input);
      case 1:
        return Delegating._decode(input);
      default:
        throw Exception('Voting: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Voting value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Casting:
        (value as Casting).encodeTo(output);
        break;
      case Delegating:
        (value as Delegating).encodeTo(output);
        break;
      default:
        throw Exception(
            'Voting: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Voting value) {
    switch (value.runtimeType) {
      case Casting:
        return (value as Casting)._sizeHint();
      case Delegating:
        return (value as Delegating)._sizeHint();
      default:
        throw Exception(
            'Voting: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Casting extends Voting {
  const Casting(this.value0);

  factory Casting._decode(_i1.Input input) {
    return Casting(_i3.Casting.codec.decode(input));
  }

  /// Casting<Balance, BlockNumber, PollIndex, MaxVotes>
  final _i3.Casting value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Casting': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Casting.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Casting.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Casting && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Delegating extends Voting {
  const Delegating(this.value0);

  factory Delegating._decode(_i1.Input input) {
    return Delegating(_i4.Delegating.codec.decode(input));
  }

  /// Delegating<Balance, AccountId, BlockNumber>
  final _i4.Delegating value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Delegating': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Delegating.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.Delegating.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Delegating && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
