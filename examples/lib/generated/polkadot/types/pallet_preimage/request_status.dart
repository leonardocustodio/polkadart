// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../frame_support/traits/tokens/fungible/hold_consideration.dart' as _i5;
import '../sp_core/crypto/account_id32.dart' as _i4;
import '../tuples.dart' as _i3;

abstract class RequestStatus {
  const RequestStatus();

  factory RequestStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RequestStatusCodec codec = $RequestStatusCodec();

  static const $RequestStatus values = $RequestStatus();

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

class $RequestStatus {
  const $RequestStatus();

  Unrequested unrequested({
    required _i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration> ticket,
    required int len,
  }) {
    return Unrequested(
      ticket: ticket,
      len: len,
    );
  }

  Requested requested({
    _i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration>? maybeTicket,
    required int count,
    int? maybeLen,
  }) {
    return Requested(
      maybeTicket: maybeTicket,
      count: count,
      maybeLen: maybeLen,
    );
  }
}

class $RequestStatusCodec with _i1.Codec<RequestStatus> {
  const $RequestStatusCodec();

  @override
  RequestStatus decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Unrequested._decode(input);
      case 1:
        return Requested._decode(input);
      default:
        throw Exception('RequestStatus: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RequestStatus value,
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
            'RequestStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RequestStatus value) {
    switch (value.runtimeType) {
      case Unrequested:
        return (value as Unrequested)._sizeHint();
      case Requested:
        return (value as Requested)._sizeHint();
      default:
        throw Exception(
            'RequestStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unrequested extends RequestStatus {
  const Unrequested({
    required this.ticket,
    required this.len,
  });

  factory Unrequested._decode(_i1.Input input) {
    return Unrequested(
      ticket: const _i3.Tuple2Codec<_i4.AccountId32, _i5.HoldConsideration>(
        _i4.AccountId32Codec(),
        _i5.HoldConsiderationCodec(),
      ).decode(input),
      len: _i1.U32Codec.codec.decode(input),
    );
  }

  /// (AccountId, Ticket)
  final _i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration> ticket;

  /// u32
  final int len;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Unrequested': {
          'ticket': [
            ticket.value0.toList(),
            ticket.value1,
          ],
          'len': len,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<_i4.AccountId32, _i5.HoldConsideration>(
          _i4.AccountId32Codec(),
          _i5.HoldConsiderationCodec(),
        ).sizeHint(ticket);
    size = size + _i1.U32Codec.codec.sizeHint(len);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i3.Tuple2Codec<_i4.AccountId32, _i5.HoldConsideration>(
      _i4.AccountId32Codec(),
      _i5.HoldConsiderationCodec(),
    ).encodeTo(
      ticket,
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
      other is Unrequested && other.ticket == ticket && other.len == len;

  @override
  int get hashCode => Object.hash(
        ticket,
        len,
      );
}

class Requested extends RequestStatus {
  const Requested({
    this.maybeTicket,
    required this.count,
    this.maybeLen,
  });

  factory Requested._decode(_i1.Input input) {
    return Requested(
      maybeTicket: const _i1
          .OptionCodec<_i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration>>(
          _i3.Tuple2Codec<_i4.AccountId32, _i5.HoldConsideration>(
        _i4.AccountId32Codec(),
        _i5.HoldConsiderationCodec(),
      )).decode(input),
      count: _i1.U32Codec.codec.decode(input),
      maybeLen: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// Option<(AccountId, Ticket)>
  final _i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration>? maybeTicket;

  /// u32
  final int count;

  /// Option<u32>
  final int? maybeLen;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Requested': {
          'maybeTicket': [
            maybeTicket?.value0.toList(),
            maybeTicket?.value1,
          ],
          'count': count,
          'maybeLen': maybeLen,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1
            .OptionCodec<_i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration>>(
            _i3.Tuple2Codec<_i4.AccountId32, _i5.HoldConsideration>(
          _i4.AccountId32Codec(),
          _i5.HoldConsiderationCodec(),
        )).sizeHint(maybeTicket);
    size = size + _i1.U32Codec.codec.sizeHint(count);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeLen);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.OptionCodec<_i3.Tuple2<_i4.AccountId32, _i5.HoldConsideration>>(
        _i3.Tuple2Codec<_i4.AccountId32, _i5.HoldConsideration>(
      _i4.AccountId32Codec(),
      _i5.HoldConsiderationCodec(),
    )).encodeTo(
      maybeTicket,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      count,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeLen,
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
          other.maybeTicket == maybeTicket &&
          other.count == count &&
          other.maybeLen == maybeLen;

  @override
  int get hashCode => Object.hash(
        maybeTicket,
        count,
        maybeLen,
      );
}
