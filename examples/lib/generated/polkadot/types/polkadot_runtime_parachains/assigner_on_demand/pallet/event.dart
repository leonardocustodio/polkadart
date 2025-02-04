// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import '../../../sp_core/crypto/account_id32.dart' as _i4;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  OnDemandOrderPlaced onDemandOrderPlaced({
    required _i3.Id paraId,
    required BigInt spotPrice,
    required _i4.AccountId32 orderedBy,
  }) {
    return OnDemandOrderPlaced(
      paraId: paraId,
      spotPrice: spotPrice,
      orderedBy: orderedBy,
    );
  }

  SpotPriceSet spotPriceSet({required BigInt spotPrice}) {
    return SpotPriceSet(spotPrice: spotPrice);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return OnDemandOrderPlaced._decode(input);
      case 1:
        return SpotPriceSet._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case OnDemandOrderPlaced:
        (value as OnDemandOrderPlaced).encodeTo(output);
        break;
      case SpotPriceSet:
        (value as SpotPriceSet).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case OnDemandOrderPlaced:
        return (value as OnDemandOrderPlaced)._sizeHint();
      case SpotPriceSet:
        return (value as SpotPriceSet)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// An order was placed at some spot price amount by orderer ordered_by
class OnDemandOrderPlaced extends Event {
  const OnDemandOrderPlaced({
    required this.paraId,
    required this.spotPrice,
    required this.orderedBy,
  });

  factory OnDemandOrderPlaced._decode(_i1.Input input) {
    return OnDemandOrderPlaced(
      paraId: _i1.U32Codec.codec.decode(input),
      spotPrice: _i1.U128Codec.codec.decode(input),
      orderedBy: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// BalanceOf<T>
  final BigInt spotPrice;

  /// T::AccountId
  final _i4.AccountId32 orderedBy;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OnDemandOrderPlaced': {
          'paraId': paraId,
          'spotPrice': spotPrice,
          'orderedBy': orderedBy.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + _i1.U128Codec.codec.sizeHint(spotPrice);
    size = size + const _i4.AccountId32Codec().sizeHint(orderedBy);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      spotPrice,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      orderedBy,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OnDemandOrderPlaced &&
          other.paraId == paraId &&
          other.spotPrice == spotPrice &&
          _i5.listsEqual(
            other.orderedBy,
            orderedBy,
          );

  @override
  int get hashCode => Object.hash(
        paraId,
        spotPrice,
        orderedBy,
      );
}

/// The value of the spot price has likely changed
class SpotPriceSet extends Event {
  const SpotPriceSet({required this.spotPrice});

  factory SpotPriceSet._decode(_i1.Input input) {
    return SpotPriceSet(spotPrice: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt spotPrice;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'SpotPriceSet': {'spotPrice': spotPrice}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(spotPrice);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      spotPrice,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpotPriceSet && other.spotPrice == spotPrice;

  @override
  int get hashCode => spotPrice.hashCode;
}
