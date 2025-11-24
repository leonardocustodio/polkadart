part of primitives;

/// The type of a chain.
///
/// This can be used by tools to determine the type of a chain for displaying
/// additional information or enabling additional features.
abstract class ChainType {
  const ChainType();

  static const $ChainTypeCodec codec = $ChainTypeCodec();

  static const $ChainType values = $ChainType();

  factory ChainType.decode(Input input) {
    return codec.decode(input);
  }

  factory ChainType.fromJson(dynamic json) {
    String type;
    if (json is String) {
      type = json;
    } else if (json is Map<String, dynamic>) {
      type = json.keys.first;
      if (type == 'Custom') {
        return Custom(json[type]);
      }
    } else {
      throw Exception('ChainType: Invalid json value: "$json"');
    }
    switch (type) {
      case 'Development':
        return const Development();
      case 'Local':
        return const Local();
      case 'Live':
        return const Live();
      default:
        throw Exception('ChainType: unknown type "$type"');
    }
  }

  Uint8List encode() {
    final output = ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, String?> toJson();
}

/// ChainType enum values
class $ChainType {
  const $ChainType();

  Development development() {
    return const Development();
  }

  Local local() {
    return const Local();
  }

  Live live() {
    return const Live();
  }

  Custom custom(String value) {
    return Custom(value);
  }
}

/// ChainType Scale Codec
class $ChainTypeCodec with Codec<ChainType> {
  const $ChainTypeCodec();

  @override
  ChainType decode(Input input) {
    final index = U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Development();
      case 1:
        return const Local();
      case 2:
        return const Live();
      case 3:
        return Custom._decode(input);
      default:
        throw Exception('ChainType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(ChainType value, Output output) {
    switch (value.runtimeType) {
      case const (Development):
        (value as Development).encodeTo(output);
        break;
      case const (Local):
        (value as Local).encodeTo(output);
        break;
      case const (Live):
        (value as Live).encodeTo(output);
        break;
      case const (Custom):
        (value as Custom).encodeTo(output);
        break;
      default:
        throw Exception('ChainType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ChainType value) {
    switch (value.runtimeType) {
      case const (Development):
      case const (Local):
      case const (Live):
        return 1;
      case const (Custom):
        return (value as Custom)._sizeHint();
      default:
        throw Exception('ChainType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() {
    // ChainType always encodes with a variant index (U8), so size is never zero
    return false;
  }
}

/// A development chain that runs mainly on one node.
class Development extends ChainType {
  const Development();

  @override
  Map<String, String?> toJson() => {'Development': null};
  void encodeTo(Output output) {
    U8Codec.codec.encodeTo(0, output);
  }
}

/// A local chain that runs locally on multiple nodes for testing purposes.
class Local extends ChainType {
  const Local();

  @override
  Map<String, String?> toJson() => {'Local': null};

  void encodeTo(Output output) {
    U8Codec.codec.encodeTo(1, output);
  }
}

/// A live chain.
class Live extends ChainType {
  const Live();

  @override
  Map<String, String?> toJson() => {'Live': null};
  void encodeTo(Output output) {
    U8Codec.codec.encodeTo(2, output);
  }
}

/// Some custom chain type.
class Custom extends ChainType {
  const Custom(this.value);

  factory Custom._decode(Input input) {
    return Custom(StrCodec.codec.decode(input));
  }

  final String value;

  @override
  Map<String, String?> toJson() => {'Custom': value};

  int _sizeHint() {
    return 1 + StrCodec.codec.sizeHint(value);
  }

  void encodeTo(Output output) {
    U8Codec.codec.encodeTo(3, output);
    StrCodec.codec.encodeTo(value, output);
  }

  @override
  bool operator ==(Object other) =>
      other is Custom && other.runtimeType == runtimeType && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
