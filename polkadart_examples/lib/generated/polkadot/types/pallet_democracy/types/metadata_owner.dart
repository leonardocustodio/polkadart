// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class MetadataOwner {
  const MetadataOwner();

  factory MetadataOwner.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MetadataOwnerCodec codec = $MetadataOwnerCodec();

  static const $MetadataOwner values = $MetadataOwner();

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

class $MetadataOwner {
  const $MetadataOwner();

  External external() {
    return External();
  }

  Proposal proposal(int value0) {
    return Proposal(value0);
  }

  Referendum referendum(int value0) {
    return Referendum(value0);
  }
}

class $MetadataOwnerCodec with _i1.Codec<MetadataOwner> {
  const $MetadataOwnerCodec();

  @override
  MetadataOwner decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const External();
      case 1:
        return Proposal._decode(input);
      case 2:
        return Referendum._decode(input);
      default:
        throw Exception('MetadataOwner: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MetadataOwner value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case External:
        (value as External).encodeTo(output);
        break;
      case Proposal:
        (value as Proposal).encodeTo(output);
        break;
      case Referendum:
        (value as Referendum).encodeTo(output);
        break;
      default:
        throw Exception(
            'MetadataOwner: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MetadataOwner value) {
    switch (value.runtimeType) {
      case External:
        return 1;
      case Proposal:
        return (value as Proposal)._sizeHint();
      case Referendum:
        return (value as Referendum)._sizeHint();
      default:
        throw Exception(
            'MetadataOwner: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class External extends MetadataOwner {
  const External();

  @override
  Map<String, dynamic> toJson() => {'External': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is External;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Proposal extends MetadataOwner {
  const Proposal(this.value0);

  factory Proposal._decode(_i1.Input input) {
    return Proposal(_i1.U32Codec.codec.decode(input));
  }

  /// PropIndex
  final int value0;

  @override
  Map<String, int> toJson() => {'Proposal': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Proposal && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Referendum extends MetadataOwner {
  const Referendum(this.value0);

  factory Referendum._decode(_i1.Input input) {
    return Referendum(_i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int value0;

  @override
  Map<String, int> toJson() => {'Referendum': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Referendum && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
