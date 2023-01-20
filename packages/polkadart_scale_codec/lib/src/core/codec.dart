part of core;

class Codec<T> implements CodecInterface<T> {
  /// TypeName for the subType
  ///
  /// It is used to precess the subType of the followed types in metadata and
  /// helps as a guided route in decoding and encoding the types following the type index from the metadata registry.
  late String subType;

  ///
  /// Current TypeName
  late String typeString;

  late int fixedLength;

  ///
  /// Set Struct BitLength
  late int bitLength;

  ///
  /// Set the typeStruct
  late List typeStruct;

  ///
  /// Set the valueList for vec
  late List valueList;

  ///
  /// Registry to hold the mapped keys and Codec
  late Registry registry;

  ///
  /// Input to be decoded
  late Input input;

  List? metadata;

  ///
  /// Constructor to initialize the registry and create Codec instance
  Codec({Registry? registry}) {
    this.registry = registry ?? TypeRegistry.createRegistry();
  }

  /// [Private]
  ///
  /// Initialize input, subType and metadata
  void _init(
    Input? input, {
    String subType = '',
    List? metadata,
  }) {
    if (input != null) {
      this.input = input;
    }
    this.subType = subType;
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
  /// final codec = Codec<bool>(registry).createTypeCodec('bool');
  /// ```
  Codec createTypeCodec(
    String typeString, {
    Input? input,
    List? metadata,
  }) {
    final Codec codec = fetchCodecType(typeString);

    codec.typeString = typeString;

    metadata ??= this.metadata;

    codec._init(input, metadata: metadata);

    return codec;
  }

  Codec fetchCodecType(String typeString) {
    typeString = _convertType(typeString);
    RegExpMatch? match;

    if (typeString.endsWith('>')) {
      final Codec? codec = registry.getCodec(typeString);
      if (codec != null) {
        return codec;
      }
      match = getVecMatch(typeString);
    }

    ///
    /// Here it seems tricky that we are checking for the match.groupCount == 2
    /// but we're accessing the match[1] and match[2] which is not possible
    ///
    /// but seems match.groupCount returns 2 when there are 3 values in the match
    if (match != null && match.groupCount == 2) {
      final Codec? codec = registry.getCodec(match[1].toString());
      if (codec != null) {
        codec.subType = match[2].toString();
        return codec;
      }
    } else {
      final Codec? codec = registry.getCodec(typeString);
      if (codec != null) {
        return codec;
      }
    }

    if (typeString.startsWith('(') && typeString.endsWith(')')) {
      final Codec codec = registry.getCodec('Tuples')!;
      codec.typeString = typeString;
      codec.buildMapping();
      return codec;
    }

    if (typeString.startsWith('[') && typeString.endsWith(']')) {
      final slice = typeString.substring(1, typeString.length - 1).split(';');
      if (slice.length == 2) {
        final subType = slice[0].trim();
        final Codec codec = (subType.toLowerCase() == 'u8'
            ? registry.getCodec('VecU8Fixed')
            : registry.getCodec('FixedArray'))!;
        codec.subType = subType;
        codec.fixedLength = int.parse(slice[1]);
        return codec;
      }
    }

    throw UnexpectedCaseException('Unknown codec type "$typeString"');
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
  T decode() {
    throw UnimplementedError();
  }

  @override
  void encode(Encoder _, T __) {
    throw UnimplementedError();
  }

  ///
  /// Asserts if the End of Input is reached.
  ///
  /// `throws [EOSException] if the input.remainingLength > 0`
  ///
  /// Please note that this method is useful only when the input is decoded from a Input.
  ///
  /// If the input is being encoded, then this method is not useful.
  void assertEOS() {
    if (input.remainingLength > 0) {
      throw EOSException();
    }
  }
}
