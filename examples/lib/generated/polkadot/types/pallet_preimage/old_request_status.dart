// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_core/crypto/account_id32.dart' as _i4;
import '../tuples.dart' as _i3;

abstract class OldRequestStatus {
  const OldRequestStatus();

  factory OldRequestStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $OldRequestStatusCodec codec = $OldRequestStatusCodec();

  static const $OldRequestStatus values = $OldRequestStatus();

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

class $OldRequestStatus {
  const $OldRequestStatus();

  Unrequested unrequested({
    required _i3.Tuple2<_i4.AccountId32, BigInt> deposit,
    required int len,
  }) {
    return Unrequested(
      deposit: deposit,
      len: len,
    );
  }

  Requested requested({
    _i3.Tuple2<_i4.AccountId32, BigInt>? deposit,
    required int count,
    int? len,
  }) {
    return Requested(
      deposit: deposit,
      count: count,
      len: len,
    );
  }
}

class $OldRequestStatusCodec with _i1.Codec<OldRequestStatus> {
  const $OldRequestStatusCodec();

  @override
  OldRequestStatus decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Unrequested._decode(input);
      case 1:
        return Requested._decode(input);
      default:
        throw Exception('OldRequestStatus: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    OldRequestStatus value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Unrequested:
        (value as Unrequested).encodeTo(output);
        break;
      case Requested:
        (value as Requested).encodeTo(output);
        break;
      default:
        throw Exception(
            'OldRequestStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(OldRequestStatus value) {
    switch (value.runtimeType) {
      case Unrequested:
        return (value as Unrequested)._sizeHint();
      case Requested:
        return (value as Requested)._sizeHint();
      default:
        throw Exception(
            'OldRequestStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unrequested extends OldRequestStatus {
  const Unrequested({
    required this.deposit,
    required this.len,
  });

  factory Unrequested._decode(_i1.Input input) {
    return Unrequested(
      deposit: const _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
        _i4.AccountId32Codec(),
        _i1.U128Codec.codec,
      ).decode(input),
      len: _i1.U32Codec.codec.decode(input),
    );
  }

  /// (AccountId, Balance)
  final _i3.Tuple2<_i4.AccountId32, BigInt> deposit;

  /// u32
  final int len;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Unrequested': {
          'deposit': [
            deposit.value0.toList(),
            deposit.value1,
          ],
          'len': len,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
          _i4.AccountId32Codec(),
          _i1.U128Codec.codec,
        ).sizeHint(deposit);
    size = size + _i1.U32Codec.codec.sizeHint(len);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
      _i4.AccountId32Codec(),
      _i1.U128Codec.codec,
    ).encodeTo(
      deposit,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      len,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unrequested && other.deposit == deposit && other.len == len;

  @override
  int get hashCode => Object.hash(
        deposit,
        len,
      );
}

class Requested extends OldRequestStatus {
  const Requested({
    this.deposit,
    required this.count,
    this.len,
  });

  factory Requested._decode(_i1.Input input) {
    return Requested(
      deposit: const _i1.OptionCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
          _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
        _i4.AccountId32Codec(),
        _i1.U128Codec.codec,
      )).decode(input),
      count: _i1.U32Codec.codec.decode(input),
      len: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// Option<(AccountId, Balance)>
  final _i3.Tuple2<_i4.AccountId32, BigInt>? deposit;

  /// u32
  final int count;

  /// Option<u32>
  final int? len;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Requested': {
          'deposit': [
            deposit?.value0.toList(),
            deposit?.value1,
          ],
          'count': count,
          'len': len,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
            _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
          _i4.AccountId32Codec(),
          _i1.U128Codec.codec,
        )).sizeHint(deposit);
    size = size + _i1.U32Codec.codec.sizeHint(count);
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(len);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.OptionCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
        _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
      _i4.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).encodeTo(
      deposit,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      count,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      len,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Requested &&
          other.deposit == deposit &&
          other.count == count &&
          other.len == len;

  @override
  int get hashCode => Object.hash(
        deposit,
        count,
        len,
      );
}
