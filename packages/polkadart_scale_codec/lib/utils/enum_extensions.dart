part of utils;

///
/// Usage:
/// ```dart
/// enum TestEnum { a, b, c }
///
/// void main() {
///   final output = HexOutput();
///
///   TestEnum.b.encodeTo(output);
///
///   print(output.toString()); // 0x00
/// }
/// ```
extension EnumExtensions<T extends core.Enum> on T {
  ///
  /// Encodes value of Enum to the [HexOutput] / [ByteOutput]
  void encodeTo(Output output) {
    output.pushByte(index);
  }
}

extension ListExtension<T extends GeneratorOutput> on List<T> {
  void encodeTo(Output output) {
    forEach((element) => element.encodeTo(output));
  }
}
