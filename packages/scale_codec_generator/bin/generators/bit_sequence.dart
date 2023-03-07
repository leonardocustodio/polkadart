import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference, literalList, literalNum;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, BitSequenceCodec, BitStore, BitOrder;
import '../metadata_parser.dart' show Primitive;
import '../constants.dart' as constants;
import './base.dart' show Generator;

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
  TypeReference primitive() {
    return constants.bitArray.type as TypeReference;
  }

  @override
  TypeReference codec() {
    return constants.bitSequenceCodec.type as TypeReference;
  }

  @override
  Expression codecInstance() {
    return codec().constInstance([
      constants.bitStore.property(store.name),
      constants.bitOrder.property(order.name),
    ]);
  }

  @override
  Expression valueFrom(Input input) {
    final bitArray = BitSequenceCodec(store, order).decode(input);
    return primitive().property('fromByteBuffer').call([
      literalNum(bitArray.length),
      constants.uint32List
          .property('fromList')
          .call([literalList(bitArray.asUint32Iterable())]).property('buffer'),
    ]);
  }
}
