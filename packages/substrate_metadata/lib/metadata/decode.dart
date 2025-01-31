import 'package:polkadart_scale_codec/io/io.dart';
import 'package:polkadart_scale_codec/primitives/primitives.dart';
import 'package:substrate_metadata/utils/utils.dart';
import '../scale_info/scale_info.dart';

class Decode {
  static void typeDef(TypeDef typeDef, Input input) {
    switch (typeDef.runtimeType) {
      case TypeDefComposite:
        print(input.toHex());
        final fields = SequenceCodec(Field.codec).decode(input);
        print(fields.toJson());

      // for (final field in (typeDef as TypeDefComposite).fields) {
      //   final name = OptionCodec(StrCodec.codec).decode(input);
      //   final type = TypeIdCodec.codec.decode(input);
      //   final typeName = OptionCodec(StrCodec.codec).decode(input);
      //   final docs = SequenceCodec(StrCodec.codec).decode(input);
      //   print(name.toJson());
      //   print(type.toJson());
      //   print(typeName.toJson());
      //   print(docs.toJson());
      // }
    }
  }
}
