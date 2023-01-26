part of core;

class Codec<T> extends CodecInterface<T> {
  /// TypeName for the subType
  ///
  /// It is used to precess the subType of the followed types in metadata and
  /// helps as a guided route in decoding and encoding the types following the type index from the metadata registry.
  Codec? subType;

  ///
  /// Current TypeName
  String typeString = '';

  int fixedLength = 0;

  ///
  /// Set Struct BitLength
  int bitLength = 0;

  ///
  /// Set the typeStruct
  List typeStruct = [];

  ///
  /// Set the valueList for vec
  List valueList = [];

  ///
  /// Registry to hold the mapped keys and Codec
  late Registry registry;

  ///
  /// Input to be decoded
  late Input input;

  List? metadata;

  ///
  /// Constructor to initialize the registry and create Codec instance
  Codec({Registry? registry})
      : registry = registry ?? TypeRegistry.createRegistry();

  @override
  Codec<T> freshInstance() {
    throw UnimplementedError();
  }

  ///
  /// Cloned the current codec instance
  dynamic copyWith(
      {required Codec codec,
      String? typeString,
      Codec? subType,
      int? fixedLength,
      int? bitLength,
      List? typeStruct,
      List? valueList,
      List? metadata}) {
    if (typeString != null) {
      codec.typeString = typeString;
    }
    if (subType != null) {
      codec.subType = subType;
    }
    if (fixedLength != null) {
      codec.fixedLength = fixedLength;
    }
    if (bitLength != null) {
      codec.bitLength = bitLength;
    }
    if (typeStruct != null) {
      codec.typeStruct = typeStruct;
    }
    if (valueList != null) {
      codec.valueList = valueList;
    }
    if (metadata != null) {
      codec.metadata = metadata;
    }
    return codec;
  }

  /// [Private]
  ///
  /// Initialize input, subType and metadata
  void init({
    required Input? input,
    Codec? subType,
    List? metadata,
  }) {
    if (input != null) {
      this.input = input;
    }
    if (subType != null) {
      this.subType = subType;
    }
    this.metadata = metadata;
  }

  ///
  /// Updates the current metadata
  void setMetadata(List metadata) {
    this.metadata = metadata;
  }

  void buildMapping() {
    typeStruct = <String>[];

    final typeStringList = typeString
        .substring(1, typeString.length - 1)
        .split(',')
        .map((element) => element.trim());

    typeStruct.addAll(typeStringList);
  }

  ///
  /// Create a codec instance
  /// [typeString] is the type of the codec
  /// [input] is the data to be decoded/encoded
  ///
  /// Example:
  /// ```dart
  /// final registry = TypeRegistry.createRegistry();
  /// final codec = Codec<bool>(registry).fetchTypeCodec('bool');
  /// ```
  Codec fetchTypeCodec(String typeString) {
    final codec = _fetchCodec(typeString);
    codec.registry = registry;
    codec.typeString = typeString;
    return codec;
  }

  Codec _fetchCodec(String typeString) {
    typeString = _convertType(typeString);
    RegExpMatch? match;

    if (typeString.endsWith('>')) {
      final Codec? codec = registry.getCodec(typeString)?.freshInstance();
      if (codec != null) {
        return codec as Vec;
      }
      match = getVecMatch(typeString);
    }

    ///
    /// Here it seems tricky that we are checking for the match.groupCount == 2
    /// but we're accessing the match[1] and match[2] which is not possible
    ///
    /// but seems match.groupCount returns 2 when there are 3 values in the match
    if (match != null && match.groupCount == 2) {
      final codec = registry.getCodec(match[1].toString())?.freshInstance();
      if (codec != null) {
        return copyWith(
            codec: codec, subType: _fetchCodec(match[2].toString()));
      }
    } else {
      final Codec? codec = registry.getCodec(typeString);
      if (codec != null) {
        return codec;
      }
    }

    if (typeString.startsWith('(') && typeString.endsWith(')')) {
      return _processTuple(typeString);
    }

    if (typeString.startsWith('[') && typeString.endsWith(']')) {
      final slice = typeString.substring(1, typeString.length - 1).split(';');
      if (slice.length == 2) {
        final subType = _fetchCodec(slice[0].trim());
        final Codec codec = (subType is U8
                ? registry.getCodec('VecU8Fixed')
                : registry.getCodec('FixedArray'))!
            .freshInstance();
        codec.subType = subType;
        codec.fixedLength = int.parse(slice[1]);
        return codec;
      }
    }

    throw UnexpectedCaseException('Unknown codec type "$typeString"');
  }

  Tuples _processTuple(String typeString) {
    final codec = registry.getCodec('Tuples')!.freshInstance();
    codec.typeString = typeString;
    codec.buildMapping();
    return codec as Tuples;
  }

  String _convertType(String codecTypeName) {
    codecTypeName = codecTypeName.trim();
    if (codecTypeName == '()') {
      return 'Null';
    }
    codecTypeName = codecTypeName.trim();
    codecTypeName = codecTypeName.replaceAll(RegExp(r'T::'), '');
    codecTypeName = codecTypeName.replaceAll(RegExp(r'VecDeque<'), 'Vec<');
    codecTypeName = codecTypeName.replaceAll(RegExp(r'<T>'), '');
    codecTypeName = codecTypeName.replaceAll(RegExp(r'<T, I>'), '');
    codecTypeName = codecTypeName.replaceAll(RegExp(r"&'static[u8]"), 'Bytes');
    if (codecTypeName == '<Lookup as StaticLookup>::Input') {
      return 'Address';
    }
    return codecTypeName;
  }

  @override
  T decode(Input input) {
    throw UnimplementedError();
  }

  @override
  void encode(Encoder encoder, T value) {
    throw UnimplementedError();
  }

  ///
  /// Asserts if the End of Input is reached.
  ///
  /// `throws [EndOfInputException] if the input.remainingLength > 0`
  ///
  /// Please note that this method is useful only when the input is decoded from a Input.
  ///
  /// If the input is being encoded, then this method is not useful.
  void assertEndOfInput() {
    if (input.remainingLength > 0) {
      throw EndOfInputException();
    }
  }
}
