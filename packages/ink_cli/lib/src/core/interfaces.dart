part of ink_cli;

class Interfaces {
  /// The "sink" that holds references to the entire type list,
  /// name assignments, etc.
  final Sink sink;

  /// A cache of computed expressions for each type index, initially empty.
  final List<String> generated;

  /// Tracks which names we have already used for top-level type definitions.
  final Set<String> generatedNames = <String>{};

  Interfaces(this.sink)
      : generated = List.filled(sink.types.length, '', growable: false);

  /// Returns (and possibly generates) the "type expression" for a given type index.
  String use(int ti) {
    // If we've already computed an expression for this type index, return it.
    final cached = generated[ti];
    if (cached.isNotEmpty) {
      return cached;
    }

    // Otherwise, let's create a new "type expression".
    String exp = _makeType(ti);

    // If the sink says "this type needs a name" or "we have a name assigned",
    // we might want to define it as a top-level type.
    if (!sink.needsName(ti) && sink.hasName(ti)) {
      final alias = sink.getName(ti);
      // If we haven't generated a top-level definition for `alias` yet, do so.
      if (!generatedNames.contains(alias)) {
        generatedNames.add(alias);
        final def = exp;
        // Push a callback to define this type into the queue (it'll run later).
        sink.push((final AbiOutput out) {
          out.line();
          out.blockComment(sink.types[ti].docs);
          out.line('typedef $alias = $def;');
        });
      }
      exp = alias;
    }

    // Cache the expression and return.
    generated[ti] = exp;
    return exp;
  }

  String _makeType(int ti) {
    final type = sink.types[ti];
    switch (type.kind) {
      // 1) Primitive
      case TypeKind.primitive:
        final prim = (type as PrimitiveCodecInterface).primitive;
        return _toNativePrimitive(prim);

      // 2) Compact
      case TypeKind.compact:
        final compactType = sink.types[(type as CompactCodecInterface).type];
        assert(compactType.kind == TypeKind.primitive);
        final prim = (compactType as PrimitiveCodecInterface).primitive;
        return _toNativePrimitive(prim);

      // 3) Bit Sequence
      case TypeKind.bitsequence:
        // For example, you might represent a bit-sequence as `Uint8List`.
        return 'Uint8List';

      // 4) Sequence / Array
      case TypeKind.sequence:
      case TypeKind.array:
        final itemTypeIndex = (type.kind == TypeKind.sequence)
            ? (type as SequenceCodecInterface).type
            : (type as ArrayCodecInterface).type;
        final itemExp = use(itemTypeIndex);
        return 'List<$itemExp>';

      // 5) Tuple
      case TypeKind.tuple:
        final tupleIndexes = (type as TupleCodecInterface).tuple;
        return _makeTuple(tupleIndexes);

      // 6) Composite (similar to struct)
      case TypeKind.composite:
        final composite = type as CompositeCodecInterface;
        // If fields are unnamed or empty, treat like a Tuple
        if (composite.fields.isEmpty || composite.fields.first.name == null) {
          final fieldIndexes = composite.fields.map((f) => f.type).toList();
          return _makeTuple(fieldIndexes);
        } else {
          // It's a named struct => generate an interface-like class or type.
          return _makeStruct(composite, ti);
        }

      // 7) Variant (encompasses 'Result', 'Option', or a general enum)
      case TypeKind.variant:
        final variant = type as VariantCodecInterface;

        // Attempt to interpret as a known "Result"
        final res = asResultType(variant);
        if (res != null) {
          final okT = (res['ok'] == null) ? 'Null' : use(res['ok'] as int);
          //final errT = (res['err'] == null) ? 'Null' : use(res['err'] as int);
          return okT;
        }

        // Attempt to interpret as an "Option"
        final opt = asOptionType(variant);
        if (opt != null) {
          final someT =
              (opt['some'] == null) ? 'Null' : use(opt['some'] as int);
          return 'Option<$someT>';
        }

        // Otherwise, treat as a standard variant (like an enum with fields).
        return _makeVariant(variant, ti);

      // 8) Option
      case TypeKind.option:
        final optT = (type as OptionCodecInterface).type;
        return '${use(optT)}?';
    }
  }

  String _makeTuple(List<int> fields) {
    if (fields.isEmpty) return 'Null';
    final typeList = fields.map((f) => use(f)).join(', ');
    return '($typeList)';
  }

  /// For composites with named fields, we generate a top-level "class" or "typedef".
  String _makeStruct(CompositeCodecInterface type, int ti) {
    final name = sink.getName(ti);
    if (generatedNames.contains(name)) {
      return name;
    }
    generatedNames.add(name);
    return name;
  }

  /// For variants, generate an ADT-like structure
  String _makeVariant(VariantCodecInterface variant, int ti) {
    final name = sink.getName(ti);
    if (generatedNames.contains(name)) {
      return name;
    }
    generatedNames.add(name);

    return name;
  }

  /// Convert ink_abi "primitive"
  String _toNativePrimitive(interfaces_base.Primitive primitive) {
    switch (primitive.name.toUpperCase()) {
      case 'I8':
      case 'U8':
      case 'I16':
      case 'U16':
      case 'I32':
      case 'U32':
        return 'int';
      case 'I64':
      case 'U64':
      case 'I128':
      case 'U128':
      case 'I256':
      case 'U256':
        return 'BigInt';
      case 'BOOL':
        return 'bool';
      case 'STR':
        return 'String';
      default:
        throw Exception('Unexpected primitive: ${primitive.name}');
    }
  }
}
