// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../polkadot_parachain/primitives/head_data.dart' as _i2;
import '../../polkadot_parachain/primitives/validation_code.dart' as _i3;

class ParaGenesisArgs {
  const ParaGenesisArgs({
    required this.genesisHead,
    required this.validationCode,
    required this.paraKind,
  });

  factory ParaGenesisArgs.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// HeadData
  final _i2.HeadData genesisHead;

  /// ValidationCode
  final _i3.ValidationCode validationCode;

  /// ParaKind
  final bool paraKind;

  static const $ParaGenesisArgsCodec codec = $ParaGenesisArgsCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'genesisHead': genesisHead,
        'validationCode': validationCode,
        'paraKind': paraKind,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParaGenesisArgs &&
          _i5.listsEqual(
            other.genesisHead,
            genesisHead,
          ) &&
          _i5.listsEqual(
            other.validationCode,
            validationCode,
          ) &&
          other.paraKind == paraKind;

  @override
  int get hashCode => Object.hash(
        genesisHead,
        validationCode,
        paraKind,
      );
}

class $ParaGenesisArgsCodec with _i1.Codec<ParaGenesisArgs> {
  const $ParaGenesisArgsCodec();

  @override
  void encodeTo(
    ParaGenesisArgs obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.genesisHead,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.validationCode,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.paraKind,
      output,
    );
  }

  @override
  ParaGenesisArgs decode(_i1.Input input) {
    return ParaGenesisArgs(
      genesisHead: _i1.U8SequenceCodec.codec.decode(input),
      validationCode: _i1.U8SequenceCodec.codec.decode(input),
      paraKind: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ParaGenesisArgs obj) {
    int size = 0;
    size = size + const _i2.HeadDataCodec().sizeHint(obj.genesisHead);
    size = size + const _i3.ValidationCodeCodec().sizeHint(obj.validationCode);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.paraKind);
    return size;
  }
}
