// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class PaymentState {
  const PaymentState();

  factory PaymentState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $PaymentStateCodec codec = $PaymentStateCodec();

  static const $PaymentState values = $PaymentState();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $PaymentState {
  const $PaymentState();

  Pending pending() {
    return Pending();
  }

  Attempted attempted({required BigInt id}) {
    return Attempted(id: id);
  }

  Failed failed() {
    return Failed();
  }
}

class $PaymentStateCodec with _i1.Codec<PaymentState> {
  const $PaymentStateCodec();

  @override
  PaymentState decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Pending();
      case 1:
        return Attempted._decode(input);
      case 2:
        return const Failed();
      default:
        throw Exception('PaymentState: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PaymentState value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Pending:
        (value as Pending).encodeTo(output);
        break;
      case Attempted:
        (value as Attempted).encodeTo(output);
        break;
      case Failed:
        (value as Failed).encodeTo(output);
        break;
      default:
        throw Exception(
            'PaymentState: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(PaymentState value) {
    switch (value.runtimeType) {
      case Pending:
        return 1;
      case Attempted:
        return (value as Attempted)._sizeHint();
      case Failed:
        return 1;
      default:
        throw Exception(
            'PaymentState: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Pending extends PaymentState {
  const Pending();

  @override
  Map<String, dynamic> toJson() => {'Pending': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Pending;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Attempted extends PaymentState {
  const Attempted({required this.id});

  factory Attempted._decode(_i1.Input input) {
    return Attempted(id: _i1.U64Codec.codec.decode(input));
  }

  /// Id
  final BigInt id;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Attempted': {'id': id}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Attempted && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class Failed extends PaymentState {
  const Failed();

  @override
  Map<String, dynamic> toJson() => {'Failed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Failed;

  @override
  int get hashCode => runtimeType.hashCode;
}
