part of models;

class Constant {
  final String type;
  final Uint8List value;
  final List<String> docs;
  const Constant({required this.type, required this.value, required this.docs});
}
