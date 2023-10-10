// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'invalid_dispute_statement_kind.dart' as _i4;
import 'valid_dispute_statement_kind.dart' as _i3;

abstract class DisputeStatement {
  const DisputeStatement();

  factory DisputeStatement.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $DisputeStatementCodec codec = $DisputeStatementCodec();

  static const $DisputeStatement values = $DisputeStatement();

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

class $DisputeStatement {
  const $DisputeStatement();

  Valid valid(_i3.ValidDisputeStatementKind value0) {
    return Valid(value0);
  }

  Invalid invalid(_i4.InvalidDisputeStatementKind value0) {
    return Invalid(value0);
  }
}

class $DisputeStatementCodec with _i1.Codec<DisputeStatement> {
  const $DisputeStatementCodec();

  @override
  DisputeStatement decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Valid._decode(input);
      case 1:
        return Invalid._decode(input);
      default:
        throw Exception('DisputeStatement: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DisputeStatement value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Valid:
        (value as Valid).encodeTo(output);
        break;
      case Invalid:
        (value as Invalid).encodeTo(output);
        break;
      default:
        throw Exception(
            'DisputeStatement: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(DisputeStatement value) {
    switch (value.runtimeType) {
      case Valid:
        return (value as Valid)._sizeHint();
      case Invalid:
        return (value as Invalid)._sizeHint();
      default:
        throw Exception(
            'DisputeStatement: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Valid extends DisputeStatement {
  const Valid(this.value0);

  factory Valid._decode(_i1.Input input) {
    return Valid(_i3.ValidDisputeStatementKind.codec.decode(input));
  }

  /// ValidDisputeStatementKind
  final _i3.ValidDisputeStatementKind value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Valid': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ValidDisputeStatementKind.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ValidDisputeStatementKind.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Valid && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Invalid extends DisputeStatement {
  const Invalid(this.value0);

  factory Invalid._decode(_i1.Input input) {
    return Invalid(_i4.InvalidDisputeStatementKind.codec.decode(input));
  }

  /// InvalidDisputeStatementKind
  final _i4.InvalidDisputeStatementKind value0;

  @override
  Map<String, String> toJson() => {'Invalid': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.InvalidDisputeStatementKind.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.InvalidDisputeStatementKind.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Invalid && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
