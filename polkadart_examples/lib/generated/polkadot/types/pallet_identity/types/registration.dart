// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../tuples.dart' as _i2;
import 'identity_info.dart' as _i4;
import 'judgement.dart' as _i3;

class Registration {
  const Registration({
    required this.judgements,
    required this.deposit,
    required this.info,
  });

  factory Registration.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedVec<(RegistrarIndex, Judgement<Balance>), MaxJudgements>
  final List<_i2.Tuple2<int, _i3.Judgement>> judgements;

  /// Balance
  final BigInt deposit;

  /// IdentityInfo<MaxAdditionalFields>
  final _i4.IdentityInfo info;

  static const $RegistrationCodec codec = $RegistrationCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'judgements': judgements
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
        'deposit': deposit,
        'info': info.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Registration &&
          _i6.listsEqual(
            other.judgements,
            judgements,
          ) &&
          other.deposit == deposit &&
          other.info == info;

  @override
  int get hashCode => Object.hash(
        judgements,
        deposit,
        info,
      );
}

class $RegistrationCodec with _i1.Codec<Registration> {
  const $RegistrationCodec();

  @override
  void encodeTo(
    Registration obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<int, _i3.Judgement>>(
        _i2.Tuple2Codec<int, _i3.Judgement>(
      _i1.U32Codec.codec,
      _i3.Judgement.codec,
    )).encodeTo(
      obj.judgements,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    _i4.IdentityInfo.codec.encodeTo(
      obj.info,
      output,
    );
  }

  @override
  Registration decode(_i1.Input input) {
    return Registration(
      judgements: const _i1.SequenceCodec<_i2.Tuple2<int, _i3.Judgement>>(
          _i2.Tuple2Codec<int, _i3.Judgement>(
        _i1.U32Codec.codec,
        _i3.Judgement.codec,
      )).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      info: _i4.IdentityInfo.codec.decode(input),
    );
  }

  @override
  int sizeHint(Registration obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<int, _i3.Judgement>>(
            _i2.Tuple2Codec<int, _i3.Judgement>(
          _i1.U32Codec.codec,
          _i3.Judgement.codec,
        )).sizeHint(obj.judgements);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + _i4.IdentityInfo.codec.sizeHint(obj.info);
    return size;
  }
}
