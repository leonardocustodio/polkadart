part of primitives;

class SimpleEnumCodec<A> with Codec<A?> {
  final List<A?> list;
  const SimpleEnumCodec(this.list);

  @override
  void encodeTo(A? value, Output output) {
    assertion(value != null, 'value should not be null.');
    final index = list.indexOf(value);
    if (index == -1) {
      throw EnumException('Invalid enum index: $index.');
    }
    if (index >= list.length) {
      throw EnumException(
          '$index is out of range. Max index is ${list.length - 1}');
    }

    if (list[index] == null) {
      throw EnumException('Value at index: $index is null, $index not usable.');
    }
    return output.pushByte(index);
  }

  @override
  A decode(Input input) {
    final index = input.read();
    if (index >= list.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    if (index >= list.length) {
      throw EnumException(
          '$index is out of range. Max index is ${list.length - 1}');
    }

    if (list[index] == null) {
      throw EnumException('Value at index: $index is null, $index not usable.');
    }

    return list[index]!;
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

class DynamicEnumCodec<V> with Codec<MapEntry<String, V>> {
  final Registry registry;
  final Map<String, dynamic> map;

  /// Complex Constructor
  const DynamicEnumCodec({required this.registry, required this.map});

  @override
  void encodeTo(MapEntry<String, V> value, Output output) {
    final index = map.keys.toList().indexOf(value.key);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${map.keys.toList()}');
    }

    output.pushByte(index);

    final type = map[value.key];

    final codec = registry.getCodec(type);

    assertion(codec != null, 'Codec for type:$type not found.');

    codec!.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V> decode(Input input) {
    final index = input.read();
    if (index >= map.keys.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    final key = map.keys.elementAt(index);

    final type = map[key];

    final codec = registry.getCodec(type);

    assertion(codec != null, 'Codec for type: $type not found.');

    return MapEntry(key, codec!.decode(input));
  }
}
