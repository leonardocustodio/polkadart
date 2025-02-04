// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../polkadot_primitives/v7/validator_app/public.dart' as _i2;

class BufferedSessionChange {
  const BufferedSessionChange({
    required this.validators,
    required this.queued,
    required this.sessionIndex,
  });

  factory BufferedSessionChange.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<ValidatorId>
  final List<_i2.Public> validators;

  /// Vec<ValidatorId>
  final List<_i2.Public> queued;

  /// SessionIndex
  final int sessionIndex;

  static const $BufferedSessionChangeCodec codec =
      $BufferedSessionChangeCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'validators': validators.map((value) => value.toList()).toList(),
        'queued': queued.map((value) => value.toList()).toList(),
        'sessionIndex': sessionIndex,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BufferedSessionChange &&
          _i4.listsEqual(
            other.validators,
            validators,
          ) &&
          _i4.listsEqual(
            other.queued,
            queued,
          ) &&
          other.sessionIndex == sessionIndex;

  @override
  int get hashCode => Object.hash(
        validators,
        queued,
        sessionIndex,
      );
}

class $BufferedSessionChangeCodec with _i1.Codec<BufferedSessionChange> {
  const $BufferedSessionChangeCodec();

  @override
  void encodeTo(
    BufferedSessionChange obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Public>(_i2.PublicCodec()).encodeTo(
      obj.validators,
      output,
    );
    const _i1.SequenceCodec<_i2.Public>(_i2.PublicCodec()).encodeTo(
      obj.queued,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.sessionIndex,
      output,
    );
  }

  @override
  BufferedSessionChange decode(_i1.Input input) {
    return BufferedSessionChange(
      validators:
          const _i1.SequenceCodec<_i2.Public>(_i2.PublicCodec()).decode(input),
      queued:
          const _i1.SequenceCodec<_i2.Public>(_i2.PublicCodec()).decode(input),
      sessionIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(BufferedSessionChange obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Public>(_i2.PublicCodec())
            .sizeHint(obj.validators);
    size = size +
        const _i1.SequenceCodec<_i2.Public>(_i2.PublicCodec())
            .sizeHint(obj.queued);
    size = size + _i1.U32Codec.codec.sizeHint(obj.sessionIndex);
    return size;
  }
}
