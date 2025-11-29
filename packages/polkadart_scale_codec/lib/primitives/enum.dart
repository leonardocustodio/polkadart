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
  final Map<String, Codec<V?>> map;

  final Map<String, int> _keyedIndex;
  final Map<int, String> _keyedName;

  ComplexEnumCodec.sparse(Map<int, MapEntry<String, Codec<V?>>> map)
      : _keyedIndex = {
          for (final entry in map.entries) entry.value.key: entry.key
        },
        _keyedName = {
          for (final entry in map.entries) entry.key: entry.value.key
        },
        map = {
          for (final entry in map.entries) entry.value.key: entry.value.value
        };

  ComplexEnumCodec.fromList(List<MapEntry<String, Codec<V?>>?> list)
      : map = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) list[i]!.key: list[i]!.value
        },
        _keyedIndex = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) list[i]!.key: i
        },
        _keyedName = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) i: list[i]!.key
        };

  @override
  void encodeTo(MapEntry<String, V?> value, Output output) {
    if (_keyedIndex[value.key] == null) {
      throw EnumException(
          'Invalid enum value: ${value.key}. Can only accept: ${_keyedIndex.keys.join(', ')}');
    }

    final int palletIndex = _keyedIndex[value.key]!;

    output.pushByte(palletIndex);

    map[value.key]!.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V?> decode(Input input) {
    final index = input.read();

    if (_keyedName[index] == null) {
      throw EnumException('Invalid enum index: $index.');
    }

    final palletName = _keyedName[index]!;

    return MapEntry(palletName, map[palletName]!.decode(input));
  }
}
