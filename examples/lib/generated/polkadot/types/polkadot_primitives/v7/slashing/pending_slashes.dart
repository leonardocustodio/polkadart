// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../validator_app/public.dart' as _i3;
import '../validator_index.dart' as _i2;
import 'slashing_offence_kind.dart' as _i4;

class PendingSlashes {
  const PendingSlashes({
    required this.keys,
    required this.kind,
  });

  factory PendingSlashes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BTreeMap<ValidatorIndex, ValidatorId>
  final Map<_i2.ValidatorIndex, _i3.Public> keys;

  /// SlashingOffenceKind
  final _i4.SlashingOffenceKind kind;

  static const $PendingSlashesCodec codec = $PendingSlashesCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'keys': keys.map((
          key,
          value,
        ) =>
            MapEntry(
              key,
              value.toList(),
            )),
        'kind': kind.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PendingSlashes &&
          _i6.mapsEqual(
            other.keys,
            keys,
          ) &&
          other.kind == kind;

  @override
  int get hashCode => Object.hash(
        keys,
        kind,
      );
}

class $PendingSlashesCodec with _i1.Codec<PendingSlashes> {
  const $PendingSlashesCodec();

  @override
  void encodeTo(
    PendingSlashes obj,
    _i1.Output output,
  ) {
    const _i1.BTreeMapCodec<_i2.ValidatorIndex, _i3.Public>(
      keyCodec: _i2.ValidatorIndexCodec(),
      valueCodec: _i3.PublicCodec(),
    ).encodeTo(
      obj.keys,
      output,
    );
    _i4.SlashingOffenceKind.codec.encodeTo(
      obj.kind,
      output,
    );
  }

  @override
  PendingSlashes decode(_i1.Input input) {
    return PendingSlashes(
      keys: const _i1.BTreeMapCodec<_i2.ValidatorIndex, _i3.Public>(
        keyCodec: _i2.ValidatorIndexCodec(),
        valueCodec: _i3.PublicCodec(),
      ).decode(input),
      kind: _i4.SlashingOffenceKind.codec.decode(input),
    );
  }

  @override
  int sizeHint(PendingSlashes obj) {
    int size = 0;
    size = size +
        const _i1.BTreeMapCodec<_i2.ValidatorIndex, _i3.Public>(
          keyCodec: _i2.ValidatorIndexCodec(),
          valueCodec: _i3.PublicCodec(),
        ).sizeHint(obj.keys);
    size = size + _i4.SlashingOffenceKind.codec.sizeHint(obj.kind);
    return size;
  }
}
