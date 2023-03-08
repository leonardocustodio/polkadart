import 'package:code_builder/code_builder.dart'
    show Expression, CodeExpression, Code, Block, TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, CompactCodec;
import '../constants.dart' as constants;
import './base.dart' show Generator, LazyLoader;

class BTreeMapGenerator extends Generator {
  late Generator key;
  late Generator value;

  BTreeMapGenerator({
    required this.key,
    required this.value,
  });

  BTreeMapGenerator._lazy();

  factory BTreeMapGenerator.lazy(
      {required LazyLoader loader, required int key, required int value}) {
    final generator = BTreeMapGenerator._lazy();
    loader.addLoader((Map<int, Generator> register) {
      generator.key = register[key]!;
      generator.value = register[value]!;
    });
    return generator;
  }

  @override
  TypeReference primitive([ String? from ]) {
    return constants.map(key.primitive(from), value.primitive(from));
  }

  @override
  TypeReference codec([ String? from ]) {
    return constants.bTreeMapCodec(key.primitive(from), value.primitive(from));
  }

  @override
  Expression codecInstance([ String? from ]) {
    return codec(from).constInstance([], {
      'keyCodec': key.codecInstance(from),
      'valueCodec': value.codecInstance(from),
    });
  }

  @override
  Expression valueFrom(Input input, [ String? from ]) {
    return CodeExpression(Block((builder) {
      builder.statements.add(Code.scope(
          (a) => '<${a(key.primitive(from))}, ${a(value.primitive(from))}>{'));
      final size = CompactCodec.codec.decode(input).toInt();
      for (var i = 0; i < size; i++) {
        final k = key.valueFrom(input, from);
        final v = value.valueFrom(input, from);
        builder.statements.addAll([
          k.code,
          Code(': '),
          v.code,
        ]);
        if (i < (size - 1)) {
          builder.statements.add(Code(', '));
        }
      }
      builder.statements.add(Code('}'));
    }));
  }
}
