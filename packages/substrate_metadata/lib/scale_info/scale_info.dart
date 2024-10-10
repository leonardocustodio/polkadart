library scale_info;

// import './utils.dart' show parseOption;
import 'dart:typed_data' show Uint8List;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        Codec,
        U32Codec,
        U8Codec,
        Input,
        Output,
        StrCodec,
        OptionCodec,
        SequenceCodec,
        ByteOutput,
        CompactCodec;

part './field.dart';
part './type_parameter.dart';
part './variant.dart';
part './type_definition.dart';
part './type_metadata.dart';
part './portable.dart';

typedef TypeId = int;

class TypeIdCodec implements Codec<TypeId> {
  const TypeIdCodec._();

  static const TypeIdCodec codec = TypeIdCodec._();

  @override
  TypeId decode(Input input) {
    return CompactCodec.codec.decode(input);
  }

  @override
  Uint8List encode(TypeId value) {
    return CompactCodec.codec.encode(value);
  }

  @override
  void encodeTo(TypeId value, Output output) {
    return CompactCodec.codec.encodeTo(value, output);
  }

  @override
  int sizeHint(TypeId value) {
    return CompactCodec.codec.sizeHint(value);
  }
}

T? parseOption<T>(dynamic obj) {
  if (obj == null) {
    return null;
  }

  T? value;
  if (obj.runtimeType == T) {
    value = obj as T;
  } else if ((obj as Map).containsKey('Some')) {
    value = obj['Some'] as T;
  }
  return value;
}

