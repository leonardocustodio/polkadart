import '../models/scale_codec_class.dart';

class EncodeMethodTemplate {
  final ScaleCodecClass scaleCodecClass;

  const EncodeMethodTemplate(this.scaleCodecClass);

  String generate() => '''
    String encode() => '';
    ''';
}
