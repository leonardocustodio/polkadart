import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show Class, Enum, TypeReference, TypeDef, Expression, Reference;
import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:code_builder/code_builder.dart' show DartEmitter, Library;
import 'package:recase/recase.dart' show ReCase;
import '../utils.dart' show sanitize;
import 'composite.dart' show CompositeGenerator;
import 'variant.dart' show VariantGenerator, Variant;

typedef BasePath = String;

abstract class Generator {
  const Generator();

  static int _idSequence = 1;
  static Map<Generator, int> generatorToId = {};
  static Map<String, TypeReference> jsonTypeCache = {};

  static String _cachedKey(BasePath from, Set<Generator> visited) {
    bool created = false;
    final ids = <int>[];
    for (final generator in visited) {
      int? id = generatorToId[generator];
      if (id == null) {
        id = _idSequence++;
        generatorToId[generator] = id;
        created = true;
      }
      ids.add(id);
    }
    ids.sort();
    final key = '$from | ${ids.join('.')}';
    if (created && jsonTypeCache.containsKey(key)) {
      throw Exception('Error, cached key collision: "$key"');
    }
    return key;
  }

  static TypeReference cacheOrCreate(BasePath from, Set<Generator> visited,
      TypeReference Function() callback) {
    final String hash = _cachedKey(from, visited);
    TypeReference? type = jsonTypeCache[hash];
    if (type == null) {
      type = callback();
      jsonTypeCache[hash] = type;
    }
    return type;
  }

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

  Expression valueFrom(BasePath from, Input input, { bool constant = false });

  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]);

  Expression instanceToJson(BasePath from, Expression obj);

  GeneratedOutput? generated() {
    return null;
  }
}

class GeneratedOutput {
  final List<TypeDef> typedefs;
  final List<Class> classes;
  final List<Enum> enums;

  static final _dartfmt = DartFormatter();

  const GeneratedOutput(
      {required this.classes, required this.enums, required this.typedefs});

  String build() {
    final library3 = Library((b) => b
      ..body.addAll(typedefs)
      ..body.addAll(enums)
      ..body.addAll(classes));

    final code = library3.accept(DartEmitter.scoped(useNullSafetySyntax: true)).toString();
    try {
      return _dartfmt.format(code);
    } catch(error) {
      throw error;
      // return code;
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
  final List<Function(Map<int, Generator>)> loaders = [];
  final Map<int, int> aliases = {};
  LazyLoader();

  void addLoader(Function(Map<int, Generator>) loader) {
    loaders.add(loader);
  }
}

class Field {
  late String? originalName;
  late String sanitizedName;
  late Generator codec;
  late List<String> docs;

  Field(
      {required String? originalName,
      required this.codec,
      required this.docs}) {
    // TODO: detect collisions
    // ex: 'foo_bar' and `fooBar` will collide
    originalName = originalName;
    if (originalName != null) {
      sanitizedName = toFieldName(originalName);
    }
  }

  Field._lazy({required String? name, required this.docs}) {
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
  }) {
    final field = Field._lazy(name: name, docs: docs);
    loader.addLoader((Map<int, Generator> register) {
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
