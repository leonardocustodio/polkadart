part of ink_cli;

class Interfaces {
  /// The "sink" that holds references to the entire type list,
  /// name assignments, etc.
  final Sink sink;

  /// A cache of computed expressions for each type index, initially empty.
  final List<String> generated;

  /// Tracks which names we have already used for top-level type definitions.
  final Set<String> generatedNames = <String>{};

  Interfaces(this.sink) : generated = List.filled(sink.types.length, '', growable: false);

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

  String _makeType(final int ti) {
    final type = sink.types[ti];
    switch (type) {
      // 1) Primitive
      case PrimitiveCodecInterface():
        return _toNativePrimitive(type.primitive);

      // 2) Compact
      case CompactCodecInterface():
        final compactType = sink.types[type.type];
        assert(compactType is PrimitiveCodecInterface);
        final prim = (compactType as PrimitiveCodecInterface).primitive;
        return _toNativePrimitive(prim);

      // 3) Bit Sequence
      case BitSequenceCodecInterface():
        // For example, you might represent a bit-sequence as `Uint8List`.
        return 'Uint8List';

      // 4) Sequence
      case SequenceCodecInterface():
        final itemTypeIndex = type.type;
        final itemExp = use(itemTypeIndex);
        return 'List<$itemExp>';
      // 5) Array
      case ArrayCodecInterface():
        final itemTypeIndex = type.type;
        final itemExp = use(itemTypeIndex);
        return 'List<$itemExp>';

      // 6) Tuple
      case TupleCodecInterface():
        final tupleIndexes = type.tuple;
        return _makeTuple(tupleIndexes);

      // 7) Composite (similar to struct)
      case CompositeCodecInterface():
        // If fields are unnamed or empty, treat like a Tuple
        if (type.fields.isEmpty || type.fields.first.name == null) {
          final fieldIndexes = type.fields.map((f) => f.type).toList();
          return _makeTuple(fieldIndexes);
        } else {
          // It's a named struct => generate an interface-like class or type.
          return _makeStruct(type, ti);
        }

      // 8) Variant (encompasses 'Result', 'Option', or a general enum)
      case VariantCodecInterface():

        // Attempt to interpret as a known "Result"
        final res = asResultType(type);
        if (res != null) {
          final okT = (res['ok'] == null) ? 'void' : use(res['ok'] as int);
          //final errT = (res['err'] == null) ? 'Null' : use(res['err'] as int);
          return okT;
        }

        // Attempt to interpret as an "Option"
        final opt = asOptionType(type);
        if (opt != null) {
          final someT = (opt['some'] == null) ? 'void' : use(opt['some'] as int);
          return 'Option<$someT>';
        }

        // Otherwise, treat as a standard variant (like an enum with fields).
        return _makeVariant(type, ti);

      // 9) Option
      case OptionCodecInterface():
        final optT = type.type;
        return '${use(optT)}?';

      default:
        throw Exception('Unknown CodecInterface Type: $type');
    }
  }

  String _makeTuple(final List<int> fields) {
    if (fields.isEmpty) return 'void';
    final typeList = fields.map((f) => use(f)).toList();
    if (typeList.length == 1) {
      return typeList[0];
    }
    return '(${typeList.join(', ')})';
  }

  /// For composites with named fields, we generate a top-level Dart class.
  String _makeStruct(CompositeCodecInterface type, int ti) {
    final name = sink.getName(ti);
    if (generatedNames.contains(name)) {
      return name;
    }
    generatedNames.add(name);

    // Push a callback to generate the class definition
    sink.push((final AbiOutput out) {
      out.line();
      out.blockComment(type.docs);
      out.block(
        start: 'class $name {',
        cb: () {
          // Generate fields
          for (final field in type.fields) {
            final fieldType = use(field.type);
            final fieldName = field.name ?? 'field${type.fields.indexOf(field)}';
            out.line('final $fieldType $fieldName;');
          }
          out.line();
          // Generate const constructor with named parameters
          if (type.fields.isEmpty) {
            out.line('const $name();');
          } else {
            final params = type.fields
                .map((f) {
                  final fieldName = f.name ?? 'field${type.fields.indexOf(f)}';
                  return 'required this.$fieldName';
                })
                .join(', ');
            out.line('const $name({$params});');
          }
        },
        end: '}',
      );
    });

    return name;
  }

  /// For variants, generate a sealed class hierarchy (Dart 3+).
  String _makeVariant(VariantCodecInterface variant, int ti) {
    final name = sink.getName(ti);
    if (generatedNames.contains(name)) {
      return name;
    }
    generatedNames.add(name);

    // Push a callback to generate the sealed class hierarchy
    sink.push((final AbiOutput out) {
      out.line();
      out.blockComment(variant.docs);
      out.line('sealed class $name {}');

      // Generate subclasses for each variant
      for (final v in variant.variants) {
        final variantClassName = '$name\$${v.name}';
        out.line();
        out.blockComment(v.docs);

        if (v.fields.isEmpty) {
          // Unit variant (no fields)
          out.line('class $variantClassName extends $name {');
          out.line('  const $variantClassName();');
          out.line('}');
        } else if (v.fields.first.name == null) {
          // Tuple-style variant (unnamed fields)
          out.block(
            start: 'class $variantClassName extends $name {',
            cb: () {
              for (int i = 0; i < v.fields.length; i++) {
                final field = v.fields[i];
                final fieldType = use(field.type);
                out.line('final $fieldType value$i;');
              }
              out.line();
              final params = List.generate(
                v.fields.length,
                (i) => 'required this.value$i',
              ).join(', ');
              out.line('const $variantClassName({$params});');
            },
            end: '}',
          );
        } else {
          // Struct-style variant (named fields)
          out.block(
            start: 'class $variantClassName extends $name {',
            cb: () {
              for (final field in v.fields) {
                final fieldType = use(field.type);
                final fieldName = field.name!;
                out.line('final $fieldType $fieldName;');
              }
              out.line();
              final params = v.fields.map((f) => 'required this.${f.name}').join(', ');
              out.line('const $variantClassName({$params});');
            },
            end: '}',
          );
        }
      }
    });

    return name;
  }

  /// Convert ink_abi "primitive"
  String _toNativePrimitive(Primitive primitive) {
    return switch (primitive) {
      Primitive.I8 ||
      Primitive.U8 ||
      Primitive.I16 ||
      Primitive.U16 ||
      Primitive.I32 ||
      Primitive.U32 => 'int',
      Primitive.I64 ||
      Primitive.U64 ||
      Primitive.I128 ||
      Primitive.U128 ||
      Primitive.I256 ||
      Primitive.U256 => 'BigInt',
      Primitive.Bool => 'bool',
      Primitive.Str => 'String',
      _ => throw Exception('Unexpected primitive: ${primitive.name}'),
    };
  }
}
