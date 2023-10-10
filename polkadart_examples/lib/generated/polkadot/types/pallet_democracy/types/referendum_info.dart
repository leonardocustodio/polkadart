// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'referendum_status.dart' as _i3;

abstract class ReferendumInfo {
  const ReferendumInfo();

  factory ReferendumInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ReferendumInfoCodec codec = $ReferendumInfoCodec();

  static const $ReferendumInfo values = $ReferendumInfo();

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

class $ReferendumInfo {
  const $ReferendumInfo();

  Ongoing ongoing(_i3.ReferendumStatus value0) {
    return Ongoing(value0);
  }

  Finished finished({
    required bool approved,
    required int end,
  }) {
    return Finished(
      approved: approved,
      end: end,
    );
  }
}

class $ReferendumInfoCodec with _i1.Codec<ReferendumInfo> {
  const $ReferendumInfoCodec();

  @override
  ReferendumInfo decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Ongoing._decode(input);
      case 1:
        return Finished._decode(input);
      default:
        throw Exception('ReferendumInfo: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ReferendumInfo value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Ongoing:
        (value as Ongoing).encodeTo(output);
        break;
      case Finished:
        (value as Finished).encodeTo(output);
        break;
      default:
        throw Exception(
            'ReferendumInfo: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ReferendumInfo value) {
    switch (value.runtimeType) {
      case Ongoing:
        return (value as Ongoing)._sizeHint();
      case Finished:
        return (value as Finished)._sizeHint();
      default:
        throw Exception(
            'ReferendumInfo: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Ongoing extends ReferendumInfo {
  const Ongoing(this.value0);

  factory Ongoing._decode(_i1.Input input) {
    return Ongoing(_i3.ReferendumStatus.codec.decode(input));
  }

  /// ReferendumStatus<BlockNumber, Proposal, Balance>
  final _i3.ReferendumStatus value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Ongoing': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ReferendumStatus.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ReferendumStatus.codec.encodeTo(
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
      other is Ongoing && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Finished extends ReferendumInfo {
  const Finished({
    required this.approved,
    required this.end,
  });

  factory Finished._decode(_i1.Input input) {
    return Finished(
      approved: _i1.BoolCodec.codec.decode(input),
      end: _i1.U32Codec.codec.decode(input),
    );
  }

  /// bool
  final bool approved;

  /// BlockNumber
  final int end;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Finished': {
          'approved': approved,
          'end': end,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(approved);
    size = size + _i1.U32Codec.codec.sizeHint(end);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      approved,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      end,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Finished && other.approved == approved && other.end == end;

  @override
  int get hashCode => Object.hash(
        approved,
        end,
      );
}
