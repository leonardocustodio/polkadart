part of descriptors;

class BitSequenceDescriptor extends TypeDescriptor {
  final int _id;
  BitStore store;
  BitOrder order;

  BitSequenceDescriptor({
    required int id,
    required this.store,
    required this.order,
  }) : _id = id;

  factory BitSequenceDescriptor.fromPrimitive({
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
    return BitSequenceDescriptor(
      id: id,
      store: store,
      order: order,
    );
  }

  @override
  int id() => _id;

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
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    return refs.list(ref: refs.int);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
