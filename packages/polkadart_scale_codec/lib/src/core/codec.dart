part of core;

class Codec<T> implements CodecInterface<T> {
  /// TypeName for the subType
  ///
  /// It is used to precess the subType of the followed types in metadata and
  /// helps as a guided route in decoding and encoding the types following the type index from the metadata registry.
  String subType = '';

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
  Codec({Registry? registry}) {
    this.registry = registry ?? TypeRegistry.createRegistry();
  }

  /// [Private]
  ///
  /// Initialize input, subType and metadata
  void init({
    required Input? input,
    String subType = '',
    List? metadata,
  }) {
    if (input != null) {
      this.input = input;
    }
    if (subType.trim().isNotEmpty) {
      this.subType = subType.trim();
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

  Codec copyWith(Codec anotherCodec) {
    throw Exception('CopyWith should be implemented in the derived class.');
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
      final Codec? codec = registry.getCodec(typeString)?.copyWith(this);
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
      final Codec? codec =
          registry.getCodec(match[1].toString())?.copyWith(this);
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
      final Codec codec = registry.getCodec('Tuples')!.copyWith(this);
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
