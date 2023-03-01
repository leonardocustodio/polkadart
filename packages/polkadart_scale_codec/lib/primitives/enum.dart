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
  final List<MapEntry<String, Codec<V?>>?> list;
  const ComplexEnumCodec(this.list);

  @override
  void encodeTo(MapEntry<String, V?> value, Output output) {
    final index = list.indexWhere((MapEntry<String, Codec<V?>>? element) =>
        element != null && element.key == value.key);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${list.cast<MapEntry<String, Codec<V?>>>().map((e) => e.key).join(', ')}');
    }
    if (index >= list.length) {
      throw EnumException(
          '$index is out of range. Max index is ${list.length - 1}');
    }

    if (list[index] == null) {
      throw EnumException('Value at index: $index is null, $index not usable.');
    }

    output.pushByte(index);

    final mapEntry = list[index]!;

    final codec = mapEntry.value;

    codec.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V?> decode(Input input) {
    final index = input.read();
    if (index >= list.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    if (list[index] == null) {
      throw EnumException('Invalid enum index: $index. $index not usable');
    }
    final mapEntry = list[index]!;

    final codec = mapEntry.value;

    return MapEntry(mapEntry.key, codec.decode(input));
  }
}

class DynamicEnumCodec<V> with Codec<MapEntry<String, String>> {
  final Registry registry;
  final List<MapEntry<String, dynamic>?> list;

  /// Complex Constructor
  const DynamicEnumCodec({required this.registry, required this.list});

  @override
  void encodeTo(MapEntry<String, String> value, Output output) {
    final index = list.indexWhere((MapEntry<String, dynamic>? element) =>
        element != null && element.key == value.key);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${list.cast<MapEntry<String, String>>().map((e) => e.key).join(', ')}');
    }
    if (index >= list.length) {
      throw EnumException(
          '$index is out of range. Max index is ${list.length - 1}');
    }

    if (list[index] == null) {
      throw EnumException('Value at index: $index is null, $index not usable.');
    }

    output.pushByte(index);

    final mapEntry = list[index]!;

    final type = mapEntry.key;

    final codec = registry.getCodec(type);

    assertion(codec != null, 'Codec for type:$type not found.');

    codec!.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, String> decode(Input input) {
    final index = input.read();
    if (index >= list.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    if (list[index] == null) {
      throw EnumException('Invalid enum index: $index. $index not usable');
    }
    final mapEntry = list[index]!;

    final type = mapEntry.key;

    final codec = registry.getCodec(type);

    assertion(codec != null, 'Codec for type: $type not found.');

    return MapEntry(mapEntry.key, codec!.decode(input));
  }
}
