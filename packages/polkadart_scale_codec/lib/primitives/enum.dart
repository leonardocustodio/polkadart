// ignore_for_file: null_check_on_nullable_type_parameter

part of primitives;

class SimpleEnumCodec<A> with Codec<A> {
  final BiMap<int, A> map = BiMap();

  SimpleEnumCodec.sparse(Map<int, A> map) {
    this.map.addAll(map);
  }

  SimpleEnumCodec.fromList(List<A?> list) {
    map.addAll({
      for (var i = 0; i < list.length; i++)
        if (list[i] != null) i: list[i]!
    });
  }

  @override
  void encodeTo(A value, Output output) {
    final index = map.inverse[value];

    if (index == null) {
      throw EnumException('Invalid enum index: $index.');
    }

    return output.pushByte(index);
  }

  @override
  A decode(Input input) {
    final index = input.read();

    final value = map[index];

    if (value == null) {
      throw EnumException('Value at index: $index is null, $index not usable.');
    }

    return value;
  }
}

class ComplexEnumCodec<V> with Codec<MapEntry<String, V?>> {
  final Map<int, MapEntry<String, Codec<V?>>> map;

  final Map<String, int> _keyedIndex;

  ComplexEnumCodec.sparse(this.map)
      : _keyedIndex = {
          for (final entry in map.entries) entry.value.key: entry.key
        };

  ComplexEnumCodec.fromList(List<MapEntry<String, Codec<V?>>?> list)
      : map = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) i: list[i]!
        },
        _keyedIndex = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) list[i]!.key: i
        };

  @override
  void encodeTo(MapEntry<String, V?> value, Output output) {
    final index = _keyedIndex[value.key];

    if (index == null) {
      throw EnumException(
          'Invalid enum value: ${value.key}. Can only accept: ${_keyedIndex.keys.join(', ')}');
    }

    output.pushByte(index);

    final mapEntry = map[index]!;

    final codec = mapEntry.value;

    codec.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V?> decode(Input input) {
    final index = input.read();

    if (map[index] == null) {
      throw EnumException('Invalid enum index: $index.');
    }

    final mapEntry = map[index]!;

    final codec = mapEntry.value;

    return MapEntry(mapEntry.key, codec.decode(input));
  }
}

class DynamicEnumCodec<V> with Codec<MapEntry<String, V>> {
  final Registry registry;
  final BiMap<int, String> map = BiMap();

  DynamicEnumCodec.sparse(
      {required this.registry, required Map<int, String> map}) {
    this.map.addAll(map);
  }

  @override
  void encodeTo(MapEntry<String, V> value, Output output) {
    final type = value.key;

    final index = map.inverse[type];

    if (index == null) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${map.values.join(', ')}');
    }

    output.pushByte(index);

    final codec = registry.getCodec(type);

    assertion(codec != null, 'Codec for type:$type not found.');

    codec!.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V> decode(Input input) {
    final index = input.read();

    final type = map[index];

    if (type == null) {
      throw EnumException('Invalid enum index: $index.');
    }

    final codec = registry.getCodec(type);

    assertion(codec != null, 'Codec for type: $type not found.');

    return MapEntry(type, codec!.decode(input));
  }
}
