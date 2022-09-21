import '../models/scale_codec_class.dart';
import 'all_params_template.dart';

class DecodeMethodTemplate {
  final ScaleCodecClass scaleCodecClass;

  const DecodeMethodTemplate(this.scaleCodecClass);

  String generate() {
    if (!scaleCodecClass.shouldCreateDecodeMethod) {
      return '';
    }
    final constructorParamTemplates =
        AllParamsTemplate(scaleCodecClass.constructor.params);

    return '''
    ${scaleCodecClass.name} decode (String encodedData) =>
    ${scaleCodecClass.name}(${constructorParamTemplates.generateParamsUsage()});
    ''';
  }
}
