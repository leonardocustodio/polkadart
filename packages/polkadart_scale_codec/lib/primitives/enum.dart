part of primitives;

class SimpleEnumCodec<A> with Codec<A> {
  final List<A> list;
  const SimpleEnumCodec(this.list);

  @override
  void encodeTo(A value, Output output) {
    final index = list.indexOf(value);
    if (index == -1) {
      throw EnumException('Invalid enum index: $index.');
    }
    return output.pushByte(index);
  }

  @override
  A decode(Input input) {
    final index = input.read();
    if (index >= list.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    return list[index];
  }
}

class ComplexEnumCodec<A> with Codec<A> {
  final Map<A, Codec> map;
  const ComplexEnumCodec(this.map);

  @override
  void encodeTo(A value, Output output) {
    final codec = map[value];
    if (codec == null) {
      throw EnumException('Invalid enum value: $value.');
    }
    return codec.encodeTo(value, output);
  }

  @override
  A decode(Input input) {
    final index = input.read();
    if (index >= map.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    final codec = map.values.elementAt(index);
    return codec.decode(input);
  }
}
