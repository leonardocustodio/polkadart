part of io;

mixin GeneratorOutput<T> {
  /// Convert self to a slice and append it to the destination.
  void encodeTo(Output output);
}
