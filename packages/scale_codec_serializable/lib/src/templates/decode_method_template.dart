import '../models/scale_codec_class.dart';
import 'all_params_template.dart';

extension DecodeMethodTemplate on ScaleCodecClass {
  String generateDecodeMethod() {
    if (!shouldCreateDecodeMethod) {
      return '';
    }
    final constructorParamTemplates = AllParamsTemplate(constructor.params);

    return '''
    $name decode (String encodedData) =>
    $name(${constructorParamTemplates.generateParamsUsage()});
    ''';
  }
}
