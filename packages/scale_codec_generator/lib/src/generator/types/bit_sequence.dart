part of generators;

class BitSequenceGenerator extends Generator {
  final int _id;
  BitStore store;
  BitOrder order;

  BitSequenceGenerator({
    required int id,
    required this.store,
    required this.order,
  }) : _id = id;

  factory BitSequenceGenerator.fromPrimitive({
    required int id,
    required metadata.Primitive primitive,
    required BitOrder order,
  }) {
    BitStore store;
    switch (primitive) {
      case metadata.Primitive.U8:
      case metadata.Primitive.I8:
        store = BitStore.U8;
        break;
      case metadata.Primitive.U16:
      case metadata.Primitive.I16:
        store = BitStore.U16;
        break;
      case metadata.Primitive.U32:
      case metadata.Primitive.I32:
        store = BitStore.U32;
        break;
      case metadata.Primitive.U64:
      case metadata.Primitive.I64:
        store = BitStore.U64;
        break;
      default:
        store = BitStore.U8;
        break;
    }
    return BitSequenceGenerator(
      id: id,
      store: store,
      order: order,
    );
  }

  @override
  TypeReference primitive(BasePath from) {
    return refs.bitArray.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return refs.bitSequenceCodec.type as TypeReference;
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from).constInstance([
      refs.bitStore.property(store.name),
      refs.bitOrder.property(order.name),
    ]);
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    final bitArray = BitSequenceCodec(store, order).decode(input);
    return primitive(from).property('fromByteBuffer').call([
      literalNum(bitArray.length),
      refs.uint32List.property('fromList').call([
        literalConstList(bitArray.asUint32Iterable().toList())
      ]).property('buffer'),
    ]);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Object> visited = const {}]) {
    return refs.list(ref: refs.int);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
