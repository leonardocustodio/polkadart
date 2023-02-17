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

class ComplexEnumCodec<V> with Codec<MapEntry<String, V?>> {
  final Map<String, Codec<V?>?> map;
  const ComplexEnumCodec(this.map);

  @override
  void encodeTo(MapEntry<String, V?> value, Output output) {
    final index = map.keys.toList().indexOf(value.key);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${map.keys.toList()}');
    }

    output.pushByte(index);

    final codec = map[value.key];

    codec?.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V?> decode(Input input) {
    final index = input.read();
    if (index >= map.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    final key = map.keys.elementAt(index);

    final codec = map[key];

    return MapEntry(key, codec?.decode(input));
  }
}
