import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference, literalConstList, literalNum;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, BitSequenceCodec, BitStore, BitOrder;
import '../frame_metadata.dart' show Primitive;
import '../constants.dart' as constants;
import './base.dart' show BasePath, Generator;

class BitSequenceGenerator extends Generator {
  BitStore store;
  BitOrder order;

  BitSequenceGenerator({
    required this.store,
    required this.order,
  });

  factory BitSequenceGenerator.fromPrimitive({
    required Primitive primitive,
    required BitOrder order,
  }) {
    BitStore store;
    switch (primitive) {
      case Primitive.U8:
      case Primitive.I8:
        store = BitStore.U8;
        break;
      case Primitive.U16:
      case Primitive.I16:
        store = BitStore.U16;
        break;
      case Primitive.U32:
      case Primitive.I32:
        store = BitStore.U32;
        break;
      case Primitive.U64:
      case Primitive.I64:
        store = BitStore.U64;
        break;
      default:
        store = BitStore.U8;
        break;
    }
    return BitSequenceGenerator(
      store: store,
      order: order,
    );
  }

  @override
  TypeReference primitive(BasePath from) {
    return constants.bitArray.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.bitSequenceCodec.type as TypeReference;
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from).constInstance([
      constants.bitStore.property(store.name),
      constants.bitOrder.property(order.name),
    ]);
  }

  @override
  Expression valueFrom(BasePath from, Input input, { bool constant = false }) {
    final bitArray = BitSequenceCodec(store, order).decode(input);
    return primitive(from).property('fromByteBuffer').call([
      literalNum(bitArray.length),
      constants.uint32List
          .property('fromList')
          .call([literalConstList(bitArray.asUint32Iterable().toList())]).property('buffer'),
    ]);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Object> visited = const {}]) {
    return constants.list(ref: constants.int);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
