import 'dart:typed_data';
import 'package:ss58/src/registry.dart';
import 'package:ss58/util/ss58_registry_json.dart' as reg;

final registry = Registry.fromJsonString(reg.jsonRegistryData);

class Codec {
  int prefix = -1;

  Codec(this.prefix) : assert(prefix >= 0 && prefix < 16384, 'invalid prefix');

  Codec.fromNetwork(String network) {
    Codec(registry.getByNetwork(network).prefix);
  }

  String encode(Uint8List bytes) {
    // TODO: Uncomment this when scale_codec encode functions is implemented
    // return encode({prefix: this.prefix, bytes});
    return '';
  }

  Uint8List decode(String s) {
    // TODO: Uncomment this when scale_codec decode functions is implemented
    //var a = decode(s);
    /* if (a.prefix != prefix) {
      throw Exception(
          'Expected an address with prefix $prefix, but $s has prefix ${a.prefix}');
    } */
    return Uint8List.fromList([]);
  }
}
