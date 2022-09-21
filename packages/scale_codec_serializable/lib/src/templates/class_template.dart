import '../models/scale_codec_class.dart';
import 'all_params_template.dart';
import 'decode_method_template.dart';
import 'encode_method_template.dart';

class ClassTemplate {
  final ScaleCodecClass scaleCodecClass;

  const ClassTemplate(this.scaleCodecClass);

  String generate() {
    final constructorParamTemplates =
        AllParamsTemplate(scaleCodecClass.constructor.params);

    final encodeMethodTemplate = EncodeMethodTemplate(scaleCodecClass);

    final decodeMethodTemplate = DecodeMethodTemplate(scaleCodecClass);
    return ''' 
    extension _\$${scaleCodecClass.name}Extension on ${scaleCodecClass.name} {
      ${constructorParamTemplates.generateEncodedFields()}

      ${encodeMethodTemplate.generate()}   

      ${decodeMethodTemplate.generate()}   
    }
    ''';
  }
}
