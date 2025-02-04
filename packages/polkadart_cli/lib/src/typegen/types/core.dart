part of descriptors;

typedef BasePath = String;

abstract class TypeDescriptor {
  const TypeDescriptor();

  static Map<int, TypeDescriptor> fromTypes(
      List<metadata.PortableType> registry, String typesPath) {
    return parseTypes(registry, typesPath);
  }

  /// Returns the id of type in the registry.
  int id();

  Expression encode(BasePath from, Expression obj,
      [Expression output = const Reference('output')]) {
    return codecInstance(from).property('encodeTo').call([obj, output]);
  }

  Expression decode(BasePath from,
      [Expression input = const Reference('input')]) {
    return codecInstance(from).property('decode').call([input]);
  }

  TypeReference primitive(BasePath from);

  TypeReference codec(BasePath from);

  Expression codecInstance(String from) {
    return codec(from).property('codec');
  }

  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false});

  TypeReference jsonType(bool isCircular, TypeBuilderContext context);

  Expression instanceToJson(BasePath from, Expression obj);
}

abstract class TypeBuilder extends TypeDescriptor {
  String filePath;

  TypeBuilder(this.filePath);

  GeneratedOutput build();
}

class GeneratedOutput {
  final List<TypeDef> typedefs;
  final List<Class> classes;
  final List<Enum> enums;

  static final _dartfmt = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  const GeneratedOutput(
      {required this.classes, required this.enums, required this.typedefs});

  String build() {
    final library3 = Library((b) => b
      ..body.addAll(typedefs)
      ..body.addAll(enums)
      ..body.addAll(classes));

    final code = library3
        .accept(DartEmitter.scoped(
            useNullSafetySyntax: true, orderDirectives: true))
        .toString();
    try {
      return _dartfmt.format(code);
    } catch (error) {
      return code;
    }
  }

  GeneratedOutput merge(GeneratedOutput other) {
    typedefs.addAll(other.typedefs);
    classes.addAll(other.classes);
    enums.addAll(other.enums);
    return this;
  }
}

class LazyLoader {
  final List<Function(Map<int, TypeDescriptor>)> loaders = [];
  final Map<int, int> aliases = {};
  LazyLoader();

  void addLoader(Function(Map<int, TypeDescriptor>) loader) {
    loaders.add(loader);
  }
}

class Field {
  /// The name of the field. None for unnamed fields.
  late String? originalName;

  /// Dart sanitized name of the field, default to `value${index}` for unnamed fields.
  late String sanitizedName;

  /// The type of the field.
  late TypeDescriptor codec;

  /// Documentation
  late List<String> docs;

  /// The name of the type of the field as it appears in the source code.
  late String? rustTypeName;

  Field(
      {required this.originalName,
      required this.codec,
      required this.docs,
      this.rustTypeName}) {
    // TODO: detect collisions
    // ex: 'foo_bar' and `fooBar` will collide
    if (originalName != null) {
      sanitizedName = toFieldName(originalName!);
    }
  }

  Field._lazy({required String? name, required this.docs, this.rustTypeName}) {
    originalName = name;
    if (originalName != null) {
      sanitizedName = toFieldName(originalName!);
    }
  }

  factory Field.lazy({
    required LazyLoader loader,
    required int codec,
    required String? name,
    List<String> docs = const [],
    String? rustTypeName,
  }) {
    final field =
        Field._lazy(name: name, docs: docs, rustTypeName: rustTypeName);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      field.codec = register[codec]!;
    });
    return field;
  }

  String originalOrSanitizedName() {
    return originalName ?? sanitizedName;
  }

  static String toFieldName(String name) {
    return sanitize(ReCase(name).camelCase);
  }
}

class TypeBuilderContext {
  final BasePath from;
  final HashMap<int, TypeReference> _jsonTypeCache = HashMap();
  final Set<TypeDescriptor> _visited = {};
  bool _isCircular = false;

  TypeBuilderContext({required this.from});

  TypeReference jsonTypeFrom(TypeDescriptor descriptor) {
    if (_isCircular) {
      throw Exception(
          'Circular reference detected, cannot call TypeBuilderContext.jsonTypeFrom');
    }

    _isCircular = _visited.contains(descriptor);
    if (!_isCircular) {
      _visited.add(descriptor);
    }

    // Check if the type is cached
    final cacheKey = descriptor.id();

    final TypeReference jsonType;
    if (_jsonTypeCache.containsKey(cacheKey)) {
      jsonType = _jsonTypeCache[cacheKey]!;
    } else {
      jsonType = descriptor.jsonType(_isCircular, this);
    }

    if (!_isCircular) {
      _jsonTypeCache[cacheKey] = jsonType;
      _visited.remove(descriptor);
    } else {
      _isCircular = false;
    }
    return jsonType;
  }
}

class _CallArgumentsIterator<T> implements Iterator<T> {
  Iterator<T>? _positionalIterator;
  final Iterator<T> _namedIterator;

  _CallArgumentsIterator(this._positionalIterator, this._namedIterator);

  @override
  T get current {
    if (_positionalIterator != null) {
      return _positionalIterator!.current;
    }
    return _namedIterator.current;
  }

  @override
  bool moveNext() {
    if (_positionalIterator != null) {
      if (!_positionalIterator!.moveNext()) {
        _positionalIterator = null;
      } else {
        return true;
      }
    }
    return _namedIterator.moveNext();
  }
}

class CallArguments<T> extends Iterable<T> {
  final List<T> positional;
  final Map<String, T> named;

  const CallArguments(this.positional, this.named);

  factory CallArguments.fromFields(List<Field> fields, T Function(Field) map) {
    final positionalArguments = <T>[];
    final namedArguments = <String, T>{};
    for (final field in fields) {
      if (field.originalName != null) {
        namedArguments[field.sanitizedName] = map(field);
      } else {
        positionalArguments.add(map(field));
      }
    }
    return CallArguments(positionalArguments, namedArguments);
  }

  @override
  Iterator<T> get iterator {
    // final List<T> list = List.from(positional);
    // list.addAll(named.values);
    // return list.iterator;
    return _CallArgumentsIterator(positional.iterator, named.values.iterator);
  }
}

class LiteralValue<E extends Expression> extends Expression {
  final E _expression;
  final bool isConstant;

  const LiteralValue(this._expression, {this.isConstant = false});

  @override
  bool get isConst => _expression.isConst || isConstant;

  @override
  R accept<R>(covariant ExpressionVisitor<R> visitor, [R? context]) =>
      _expression.accept(visitor, context);

  @override
  Code get code => _expression.code;

  @override
  Code get statement => _expression.statement;

  @override
  Expression and(Expression other) => _expression.and(other);

  @override
  Expression or(Expression other) => _expression.or(other);

  @override
  Expression negate() => _expression.negate();

  @override
  Expression asA(Expression other) => _expression.asA(other);

  @override
  Expression index(Expression index) => _expression.index(index);

  @override
  Expression isA(Expression other) => _expression.isA(other);

  @override
  Expression isNotA(Expression other) => _expression.isNotA(other);

  @override
  Expression equalTo(Expression other) => _expression.equalTo(other);

  @override
  Expression notEqualTo(Expression other) => _expression.notEqualTo(other);

  @override
  Expression greaterThan(Expression other) => _expression.greaterThan(other);

  @override
  Expression lessThan(Expression other) => _expression.lessThan(other);

  @override
  Expression greaterOrEqualTo(Expression other) =>
      _expression.greaterOrEqualTo(other);

  @override
  Expression lessOrEqualTo(Expression other) =>
      _expression.lessOrEqualTo(other);

  @override
  Expression operatorAdd(Expression other) => _expression.operatorAdd(other);

  @override
  Expression operatorSubtract(Expression other) =>
      _expression.operatorSubtract(other);

  @override
  Expression operatorDivide(Expression other) =>
      _expression.operatorDivide(other);

  @override
  Expression operatorMultiply(Expression other) =>
      _expression.operatorMultiply(other);

  @override
  Expression operatorEuclideanModulo(Expression other) =>
      _expression.operatorEuclideanModulo(other);

  @override
  Expression conditional(Expression whenTrue, Expression whenFalse) =>
      _expression.conditional(whenTrue, whenFalse);

  @override
  Expression get awaited => _expression.awaited;

  @override
  Expression assign(Expression other) => _expression.assign(other);

  @override
  Expression ifNullThen(Expression other) => _expression.ifNullThen(other);

  @override
  Expression assignNullAware(Expression other) =>
      _expression.assignNullAware(other);

  @override
  Expression call(
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) =>
      _expression.call(positionalArguments, namedArguments, typeArguments);

  @override
  Expression property(String name) => _expression.property(name);

  @override
  Expression cascade(String name) => _expression.cascade(name);

  @override
  Expression nullSafeProperty(String name) =>
      _expression.nullSafeProperty(name);

  @override
  Expression get nullChecked => _expression.nullChecked;

  @override
  Expression get returned => _expression.returned;

  @override
  Expression get spread => _expression.spread;

  @override
  Expression get nullSafeSpread => _expression.nullSafeSpread;

  @override
  Expression get thrown => _expression.thrown;

  @override
  Expression get expression => _expression;
}

/// Helper to make a type nullable
extension LiteralValueExtension on Expression {
  LiteralValue asLiteralConstant() {
    return LiteralValue(this, isConstant: true);
  }

  LiteralValue asLiteralValue({isConstant = false}) {
    return LiteralValue(this, isConstant: isConstant);
  }
}
