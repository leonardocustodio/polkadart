part of generators;

class BitSequenceGenerator extends Generator {
  BitStore store;
  BitOrder order;

  BitSequenceGenerator({
    required this.store,
    required this.order,
  });

  factory BitSequenceGenerator.fromPrimitive({
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
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    final bitArray = BitSequenceCodec(store, order).decode(input);
    return primitive(from).property('fromByteBuffer').call([
      literalNum(bitArray.length),
      constants.uint32List.property('fromList').call([
        literalConstList(bitArray.asUint32Iterable().toList())
      ]).property('buffer'),
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
