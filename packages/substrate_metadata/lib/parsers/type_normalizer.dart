part of parsers;

class TypeNormalizer {
  ///
  /// Types available of the chain
  final Map<String, dynamic> types;

  ///
  /// Types alias available of the chain where the substitutions are made in different spec versions
  final Map<String, Map<String, String>> typesAlias;

  ///
  /// Constructor
  const TypeNormalizer({required this.types, required this.typesAlias});

  static final Map<String, RegistryType> _cachedTypes =
      <String, RegistryType>{};

  ///
  /// Normalize the type expression
  RegistryType normalize(String typeExp, [String? pallet]) {
    //
    // Trying to find the cached type from the types
    if (_cachedTypes[typeExp] != null) {
      return _cachedTypes[typeExp]!;
    }

    if (pallet != null) {
      if (_cachedTypes['$pallet.$typeExp'] != null) {
        return _cachedTypes['$pallet.$typeExp']!;
      }

      ///
      /// If the pallet is provided, we try to normalize the type expression
      _cachedTypes['$pallet.$typeExp'] = _normalizeType(
        TypeExpParser.instance[typeExp],
        pallet,
      );

      return _cachedTypes['$pallet.$typeExp']!;
    }

    ///
    /// The pallet is not provided, we try to normalize the type expression without pallet
    _cachedTypes[typeExp] = _normalizeType(
      TypeExpParser.instance[typeExp],
      pallet,
    );

    return _cachedTypes[typeExp]!;
  }

  RegistryType _normalizeType(RegistryType type, String? pallet) {
    switch (type.kind) {
      case 'array':
        return RegistryArrayType(
          item: _normalizeType((type as RegistryArrayType).item, pallet),
          length: type.length,
        );
      case 'tuple':
        return RegistryTupleType(
          params: (type as RegistryTupleType).params.map((item) {
            return _normalizeType(item, pallet);
          }).toList(growable: false),
        );
      default:
        return _normalizeNamedType(type as RegistryNamedType, pallet);
    }
  }

  RegistryType _normalizeNamedType(RegistryNamedType type, String? pallet) {
    if (pallet != null) {
      final section = pallet.camelCase;
      final alias = typesAlias[section]?[type.name];
      if (isNotEmpty(alias)) {
        return RegistryNamedType(
          name: alias!,
          params: [],
        );
      }
    }

    if (isNotEmpty(types[type.name])) {
      return RegistryNamedType(
        name: type.name,
        params: [],
      );
    }

    final primitive = _asPrimitive(type.name);
    if (primitive != null) {
      _assertNoParams(type);
      return RegistryNamedType(
        name: primitive,
        params: [],
      );
    }

    switch (type.name) {
      case 'Null':
        return RegistryTupleType(
          params: [],
        );
      case 'UInt':
        return RegistryNamedType(
          name: _convertGenericIntegerToPrimitive('U', type),
          params: [],
        );
      case 'Int':
        return RegistryNamedType(
          name: _convertGenericIntegerToPrimitive('I', type),
          params: [],
        );
      case 'Box':
        return _normalizeType(_assertOneParam(type), pallet);
      case 'Bytes':
        _assertNoParams(type);

        return RegistryNamedType(
          name: 'Vec',
          params: [
            RegistryNamedType(
              name: 'U8',
              params: [],
            ),
          ],
        );
      case 'Vec':
      case 'VecDeque':
      case 'WeakVec':
      case 'BoundedVec':
      case 'WeakBoundedVec':
        {
          final param = _normalizeType(_assertOneParam(type), pallet);
          return RegistryNamedType(
            name: 'Vec',
            params: [param],
          );
        }
      case 'BTreeMap':
      case 'BoundedBTreeMap':
        {
          final list = _assertTwoParams(type);
          final key = list[0];
          final value = list[1];
          return _normalizeType(
              RegistryNamedType(
                name: 'Vec',
                params: [
                  RegistryTupleType(params: [key, value])
                ],
              ),
              pallet);
        }
      case 'BTreeSet':
      case 'BoundedBTreeSet':
        return _normalizeType(
            RegistryNamedType(name: 'Vec', params: [_assertOneParam(type)]),
            pallet);
      case 'RawAddress':
        return _normalizeType(
            RegistryNamedType(
              name: 'Address',
              params: [],
            ),
            pallet);
      case 'PairOf':
      case 'Range':
      case 'RangeInclusive':
        {
          final param = _normalizeType(_assertOneParam(type), pallet);
          return RegistryTupleType(params: [param, param]);
        }
      default:
        return RegistryNamedType(
            name: type.name,
            params: type.params
                .map((p) => p is int ? p : _normalizeType(p, pallet))
                .toList(growable: false));
    }
  }

  RegistryType _assertOneParam(RegistryNamedType type) {
    if (type.params.isEmpty) {
      throw Exception(
          'Invalid type ${type.toString()}: one type parameter expected');
    }
    final param = type.params[0];
    if (param is int) {
      throw Exception(
          'Invalid type ${type.toString()}: type parameter should refer to a type, not to bit size');
    }
    return param;
  }

  List<RegistryType> _assertTwoParams(RegistryNamedType type) {
    if (type.params.length < 2) {
      throw Exception(
          'Invalid type ${type.toString()}: two type parameters expected');
    }
    final param1 = type.params[0];
    if (param1 is int) {
      throw Exception(
          'Invalid type ${type.toString()}: first type parameter should refer to a type, not to bit size');
    }
    final param2 = type.params[1];
    if (param2 is int) {
      throw Exception(
          'Invalid type ${type.toString()}: second type parameter should refer to a type, not to bit size');
    }
    return [param1, param2];
  }

  void _assertNoParams(RegistryNamedType type) {
    if (type.params.isNotEmpty) {
      throw Exception(
          'Invalid type ${type.toString()}: no type parameters expected for ${type.name}');
    }
  }

  String _convertGenericIntegerToPrimitive(
      String kind, RegistryNamedType type) {
    if (type.params.isEmpty) {
      throw Exception(
          'Invalid type ${type.toString()}: bit size is not specified');
    }
    final size = type.params[0];
    if (size is! int) {
      throw Exception(
          'Invalid type ${type.toString()}: bit size expected as a first type parameter, e.g. ${type.name}<32>');
    }
    switch (size) {
      case 8:
      case 16:
      case 32:
      case 64:
      case 128:
      case 256:
        return '$kind$size';
      default:
        throw Exception(
            'Invalid type ${type.toString()}: invalid bit size $size');
    }
  }

  String? _asPrimitive(String name) {
    switch (name.toLowerCase()) {
      case 'i8':
      case 'i16':
      case 'i32':
      case 'i64':
      case 'i128':
      case 'i256':
      case 'u8':
      case 'u16':
      case 'u32':
      case 'u64':
      case 'u128':
      case 'u256':
      case 'bool':
      case 'str':
      case 'string':
      case 'text':
        return name;
      default:
        return null;
    }
  }
}
