// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i2;

class Nominations {
  const Nominations({
    required this.targets,
    required this.submittedIn,
    required this.suppressed,
  });

  factory Nominations.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedVec<T::AccountId, MaxNominationsOf<T>>
  final List<_i2.AccountId32> targets;

  /// EraIndex
  final int submittedIn;

  /// bool
  final bool suppressed;

  static const $NominationsCodec codec = $NominationsCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'targets': targets.map((value) => value.toList()).toList(),
        'submittedIn': submittedIn,
        'suppressed': suppressed,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Nominations &&
          _i4.listsEqual(
            other.targets,
            targets,
          ) &&
          other.submittedIn == submittedIn &&
          other.suppressed == suppressed;

  @override
  int get hashCode => Object.hash(
        targets,
        submittedIn,
        suppressed,
      );
}

class $NominationsCodec with _i1.Codec<Nominations> {
  const $NominationsCodec();

  @override
  void encodeTo(
    Nominations obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.targets,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.submittedIn,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.suppressed,
      output,
    );
  }

  @override
  Nominations decode(_i1.Input input) {
    return Nominations(
      targets: const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      submittedIn: _i1.U32Codec.codec.decode(input),
      suppressed: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Nominations obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.targets);
    size = size + _i1.U32Codec.codec.sizeHint(obj.submittedIn);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.suppressed);
    return size;
  }
}
