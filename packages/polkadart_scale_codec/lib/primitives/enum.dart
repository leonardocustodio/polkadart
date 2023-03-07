// ignore_for_file: null_check_on_nullable_type_parameter

part of primitives;

class SimpleEnumCodec<A> with Codec<A> {
  final Map<int, A> map;

  final Map<A, int> _keyedIndex;

  SimpleEnumCodec.sparse(this.map)
      : _keyedIndex = {for (final entry in map.entries) entry.value: entry.key};

  SimpleEnumCodec.keyedIndex(this._keyedIndex)
      : map = {for (final entry in _keyedIndex.entries) entry.value: entry.key};

  SimpleEnumCodec.fromList(List<A?> list)
      : map = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) i: list[i]!
        },
        _keyedIndex = {
          for (var i = 0; i < list.length; i++)
            if (list[i] != null) list[i]!: i
        };

  @override
  void encodeTo(A value, Output output) {
    final index = _keyedIndex[value];

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
  final Map<int, String> map;

  final Map<String, int> keyedIndex;

  DynamicEnumCodec.sparse({required this.registry, required this.map})
      : keyedIndex = {for (final entry in map.entries) entry.value: entry.key};

  DynamicEnumCodec.keyedIndex(
      {required this.registry, required this.keyedIndex})
      : map = {for (final entry in keyedIndex.entries) entry.value: entry.key};

  @override
  void encodeTo(MapEntry<String, V> value, Output output) {
    final type = value.key;

    final index = keyedIndex[type];

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
    if (codec == null) {
      print('here');
    }

    assertion(codec != null, 'Codec for type: $type not found.');

    return MapEntry(type, codec!.decode(input));
  }
}
