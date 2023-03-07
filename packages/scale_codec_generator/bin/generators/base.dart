import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show Class, Enum, TypeReference, TypeDef, Expression, Reference;
import 'package:dart_style/dart_style.dart' show DartFormatter;
import 'package:code_builder/code_builder.dart' show DartEmitter, Library;
import 'package:recase/recase.dart' show ReCase;
import '../utils.dart' show sanitize;

abstract class Generator {
  const Generator();

  Expression encode(Expression obj,
      [Expression output = const Reference('output')]) {
    return codecInstance().property('encodeTo').call([obj, output]);
  }

  Expression decode([Expression input = const Reference('input')]) {
    return codecInstance().property('decode').call([input]);
  }

  TypeReference primitive();

  TypeReference codec();

  Expression codecInstance() {
    return codec().property('codec');
  }

  Expression valueFrom(Input input);

  GeneratedOutput? generated() {
    return null;
  }

  bool isEquivalentTo(Generator other, [Set<Generator> visited = const {}]) {
    if (identical(this, other) || visited.contains(this)) {
      return true;
    }
    final selfPrimitive = primitive();
    final otherPrimitive = other.primitive();
    if (selfPrimitive.symbol != otherPrimitive.symbol) {
      return false;
    }

    if (runtimeType != other.runtimeType) {
      return false;
    }
    visited.add(this);
    return other.isEquivalentTo(this);
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
    return _dartfmt.format(
        '${library3.accept(DartEmitter.scoped(useNullSafetySyntax: true))}');
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
  late String name;
  late Generator codec;
  late List<String> docs;

  Field({required String name, required this.codec, required this.docs}) {
    // TODO: detect collisions
    // ex: 'foo_bar' and `fooBar` will collide
    this.name = toFieldName(name);
  }

  Field._lazy({required String name, required this.docs}) {
    this.name = toFieldName(name);
  }

  factory Field.lazy({
    required LazyLoader loader,
    required int codec,
    required String name,
    List<String> docs = const [],
  }) {
    final field = Field._lazy(name: name, docs: docs);
    loader.addLoader((Map<int, Generator> register) {
      field.codec = register[codec]!;
    });
    return field;
  }

  static String toFieldName(String name) {
    return sanitize(ReCase(name).camelCase);
  }
}
