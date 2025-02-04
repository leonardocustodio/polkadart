// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  PlaceOrderAllowDeath placeOrderAllowDeath({
    required BigInt maxAmount,
    required _i3.Id paraId,
  }) {
    return PlaceOrderAllowDeath(
      maxAmount: maxAmount,
      paraId: paraId,
    );
  }

  PlaceOrderKeepAlive placeOrderKeepAlive({
    required BigInt maxAmount,
    required _i3.Id paraId,
  }) {
    return PlaceOrderKeepAlive(
      maxAmount: maxAmount,
      paraId: paraId,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return PlaceOrderAllowDeath._decode(input);
      case 1:
        return PlaceOrderKeepAlive._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case PlaceOrderAllowDeath:
        (value as PlaceOrderAllowDeath).encodeTo(output);
        break;
      case PlaceOrderKeepAlive:
        (value as PlaceOrderKeepAlive).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case PlaceOrderAllowDeath:
        return (value as PlaceOrderAllowDeath)._sizeHint();
      case PlaceOrderKeepAlive:
        return (value as PlaceOrderKeepAlive)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Create a single on demand core order.
/// Will use the spot price for the current block and will reap the account if needed.
///
/// Parameters:
/// - `origin`: The sender of the call, funds will be withdrawn from this account.
/// - `max_amount`: The maximum balance to withdraw from the origin to place an order.
/// - `para_id`: A `ParaId` the origin wants to provide blockspace for.
///
/// Errors:
/// - `InsufficientBalance`: from the Currency implementation
/// - `QueueFull`
/// - `SpotPriceHigherThanMaxAmount`
///
/// Events:
/// - `OnDemandOrderPlaced`
class PlaceOrderAllowDeath extends Call {
  const PlaceOrderAllowDeath({
    required this.maxAmount,
    required this.paraId,
  });

  factory PlaceOrderAllowDeath._decode(_i1.Input input) {
    return PlaceOrderAllowDeath(
      maxAmount: _i1.U128Codec.codec.decode(input),
      paraId: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt maxAmount;

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'place_order_allow_death': {
          'maxAmount': maxAmount,
          'paraId': paraId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(maxAmount);
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      maxAmount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PlaceOrderAllowDeath &&
          other.maxAmount == maxAmount &&
          other.paraId == paraId;

  @override
  int get hashCode => Object.hash(
        maxAmount,
        paraId,
      );
}

/// Same as the [`place_order_allow_death`](Self::place_order_allow_death) call , but with a
/// check that placing the order will not reap the account.
///
/// Parameters:
/// - `origin`: The sender of the call, funds will be withdrawn from this account.
/// - `max_amount`: The maximum balance to withdraw from the origin to place an order.
/// - `para_id`: A `ParaId` the origin wants to provide blockspace for.
///
/// Errors:
/// - `InsufficientBalance`: from the Currency implementation
/// - `QueueFull`
/// - `SpotPriceHigherThanMaxAmount`
///
/// Events:
/// - `OnDemandOrderPlaced`
class PlaceOrderKeepAlive extends Call {
  const PlaceOrderKeepAlive({
    required this.maxAmount,
    required this.paraId,
  });

  factory PlaceOrderKeepAlive._decode(_i1.Input input) {
    return PlaceOrderKeepAlive(
      maxAmount: _i1.U128Codec.codec.decode(input),
      paraId: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt maxAmount;

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'place_order_keep_alive': {
          'maxAmount': maxAmount,
          'paraId': paraId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(maxAmount);
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      maxAmount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PlaceOrderKeepAlive &&
          other.maxAmount == maxAmount &&
          other.paraId == paraId;

  @override
  int get hashCode => Object.hash(
        maxAmount,
        paraId,
      );
}
