import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow('`@ScaleCodecSerializable` can only be used on classes.')
@ScaleCodecSerializable()
enum EnumExample {
  test,
  test2;
}
