import '../models/scale_codec_class.dart';
import 'all_params_template.dart';
import 'decode_method_template.dart';
import 'encode_method_template.dart';

extension ClassTemplate on ScaleCodecClass {
  /// Generates a class template for [ScaleCodecClass] like
  /// the example below:
  /// ```
  /// extension _$ExampleExtension on Example {
  ///   String varEncoded = '';
  ///
  ///   String encode() => '';
  ///
  ///   Example decode(String encodedData) => Example();
  /// }
  /// ```
  String generateClassTemplate() {
    final constructorParamTemplates = AllParamsTemplate(constructor.params);

    return ''' 
    extension _\$${name}Extension on $name {
      ${constructorParamTemplates.generateEncodedFields()}

      ${generateEncodeMethod()}   

      ${generateDecodeMethod()}   
    }
    ''';
  }
}
