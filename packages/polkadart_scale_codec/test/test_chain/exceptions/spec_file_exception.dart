class SpecFileException implements Exception {
  const SpecFileException([this.msg]);

  final String? msg;

  @override
  String toString() {
    return msg ?? 'Spec File Exception';
  }
}
