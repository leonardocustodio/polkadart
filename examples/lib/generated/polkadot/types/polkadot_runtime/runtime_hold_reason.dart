// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../pallet_preimage/pallet/hold_reason.dart' as _i3;
import '../pallet_state_trie_migration/pallet/hold_reason.dart' as _i4;

abstract class RuntimeHoldReason {
  const RuntimeHoldReason();

  factory RuntimeHoldReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeHoldReasonCodec codec = $RuntimeHoldReasonCodec();

  static const $RuntimeHoldReason values = $RuntimeHoldReason();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, String> toJson();
}

class $RuntimeHoldReason {
  const $RuntimeHoldReason();

  Preimage preimage(_i3.HoldReason value0) {
    return Preimage(value0);
  }

  StateTrieMigration stateTrieMigration(_i4.HoldReason value0) {
    return StateTrieMigration(value0);
  }
}

class $RuntimeHoldReasonCodec with _i1.Codec<RuntimeHoldReason> {
  const $RuntimeHoldReasonCodec();

  @override
  RuntimeHoldReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 10:
        return Preimage._decode(input);
      case 98:
        return StateTrieMigration._decode(input);
      default:
        throw Exception('RuntimeHoldReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeHoldReason value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Preimage:
        (value as Preimage).encodeTo(output);
        break;
      case StateTrieMigration:
        (value as StateTrieMigration).encodeTo(output);
        break;
      default:
        throw Exception(
            'RuntimeHoldReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeHoldReason value) {
    switch (value.runtimeType) {
      case Preimage:
        return (value as Preimage)._sizeHint();
      case StateTrieMigration:
        return (value as StateTrieMigration)._sizeHint();
      default:
        throw Exception(
            'RuntimeHoldReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Preimage extends RuntimeHoldReason {
  const Preimage(this.value0);

  factory Preimage._decode(_i1.Input input) {
    return Preimage(_i3.HoldReason.codec.decode(input));
  }

  /// pallet_preimage::HoldReason
  final _i3.HoldReason value0;

  @override
  Map<String, String> toJson() => {'Preimage': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.HoldReason.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i3.HoldReason.codec.encodeTo(
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
      other is Preimage && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class StateTrieMigration extends RuntimeHoldReason {
  const StateTrieMigration(this.value0);

  factory StateTrieMigration._decode(_i1.Input input) {
    return StateTrieMigration(_i4.HoldReason.codec.decode(input));
  }

  /// pallet_state_trie_migration::HoldReason
  final _i4.HoldReason value0;

  @override
  Map<String, String> toJson() => {'StateTrieMigration': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.HoldReason.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      98,
      output,
    );
    _i4.HoldReason.codec.encodeTo(
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
      other is StateTrieMigration && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
