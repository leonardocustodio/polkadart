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

class ComplexEnumCodec<V> with Codec<Map<String, V>> {
  final Map<String, Codec<V>> map;
  const ComplexEnumCodec(this.map);

  @override
  void encodeTo(Map<String, V> value, Output output) {
    if (value.length != 1) {
      throw EnumException(
          'Expected exactly one key/value pair, but got multiple: $value.');
    }

    final index = map.keys.toList().indexOf(value.keys.first);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${map.keys.toList()}');
    }

    output.pushByte(index);

    final codec = map[value.keys.first]!;

    return codec.encodeTo(value[value.keys.first] as V, output);
  }

  @override
  Map<String, V> decode(Input input) {
    final index = input.read();
    if (index >= map.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    final key = map.keys.elementAt(index);

    final codec = map[key]!;

    return <String, V>{key: codec.decode(input)};
  }
}
