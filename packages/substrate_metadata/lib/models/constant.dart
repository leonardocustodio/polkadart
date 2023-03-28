part of models;

class Constant {
  final Codec type;
  final Uint8List bytes;
  final List<String> docs;
  const Constant({required this.type, required this.bytes, required this.docs});

  dynamic get value {
    return type.decode(Input.fromBytes(bytes));
  }
}
