// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_parachain/primitives/validation_code_hash.dart' as _i2;
import 'validator_index.dart' as _i3;

class PvfCheckStatement {
  const PvfCheckStatement({
    required this.accept,
    required this.subject,
    required this.sessionIndex,
    required this.validatorIndex,
  });

  factory PvfCheckStatement.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// bool
  final bool accept;

  /// ValidationCodeHash
  final _i2.ValidationCodeHash subject;

  /// SessionIndex
  final int sessionIndex;

  /// ValidatorIndex
  final _i3.ValidatorIndex validatorIndex;

  static const $PvfCheckStatementCodec codec = $PvfCheckStatementCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'accept': accept,
        'subject': subject.toList(),
        'sessionIndex': sessionIndex,
        'validatorIndex': validatorIndex,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PvfCheckStatement &&
          other.accept == accept &&
          other.subject == subject &&
          other.sessionIndex == sessionIndex &&
          other.validatorIndex == validatorIndex;

  @override
  int get hashCode => Object.hash(
        accept,
        subject,
        sessionIndex,
        validatorIndex,
      );
}

class $PvfCheckStatementCodec with _i1.Codec<PvfCheckStatement> {
  const $PvfCheckStatementCodec();

  @override
  void encodeTo(
    PvfCheckStatement obj,
    _i1.Output output,
  ) {
    _i1.BoolCodec.codec.encodeTo(
      obj.accept,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.subject,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.sessionIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validatorIndex,
      output,
    );
  }

  @override
  PvfCheckStatement decode(_i1.Input input) {
    return PvfCheckStatement(
      accept: _i1.BoolCodec.codec.decode(input),
      subject: const _i1.U8ArrayCodec(32).decode(input),
      sessionIndex: _i1.U32Codec.codec.decode(input),
      validatorIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PvfCheckStatement obj) {
    int size = 0;
    size = size + _i1.BoolCodec.codec.sizeHint(obj.accept);
    size = size + const _i2.ValidationCodeHashCodec().sizeHint(obj.subject);
    size = size + _i1.U32Codec.codec.sizeHint(obj.sessionIndex);
    size = size + const _i3.ValidatorIndexCodec().sizeHint(obj.validatorIndex);
    return size;
  }
}
