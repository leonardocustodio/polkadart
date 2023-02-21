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

class ComplexEnumCodec<V> with Codec<MapEntry<String, V>> {
  final Map<String, Codec<V>> map;
  const ComplexEnumCodec(this.map);

  @override
  void encodeTo(MapEntry<String, V> value, Output output) {
    final index = map.keys.toList().indexOf(value.key);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${map.keys.toList()}');
    }

    output.pushByte(index);

    final codec = map[value.key]!;

    return codec.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V> decode(Input input) {
    final index = input.read();
    if (index >= map.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    final key = map.keys.elementAt(index);

    final codec = map[key]!;

    return MapEntry(key, codec.decode(input));
  }
}

class DynamicEnumCodec<V> with Codec<MapEntry<String, V>> {
  final Registry registry;
  final List<String> keys;
  final bool _isSimple;

  ///
  /// In complex the keys are the names of the enum variants which have parameters
  ///
  /// {
  ///   'Apple': 'u8',
  ///   'Orange': 'bool',
  /// }
  ///
  /// // keys = ['Apple', 'Orange']
  ///
  /// Here the 'Apple' is mapped to a u8 and 'Orange' is mapped to a bool and is used to decode/encode further.
  const DynamicEnumCodec.complex({required this.registry, required this.keys})
      : _isSimple = false;

  ///
  /// In simple the keys are the names of the enum variants which have no parameters
  ///
  /// // keys = ['Apple', 'Orange']
  const DynamicEnumCodec.simple({required this.registry, required this.keys})
      : _isSimple = true;

  @override
  void encodeTo(MapEntry<String, V> value, Output output) {
    final index = keys.toList().indexOf(value.key);

    if (index == -1) {
      throw EnumException(
          'Invalid enum value: $value. Can only accept: ${keys.toList()}');
    }

    output.pushByte(index);

    if (_isSimple) {
      return;
    }
    final codec = registry.getCodec(value.key);

    assertion(codec != null, 'Codec for ${value.key} not found');

    codec!.encodeTo(value.value, output);
  }

  @override
  MapEntry<String, V> decode(Input input) {
    final index = input.read();
    if (index >= keys.length) {
      throw EnumException('Invalid enum index: $index.');
    }
    final key = keys.elementAt(index);

    if (_isSimple) {
      return MapEntry(key, null as V);
    }

    final codec = registry.getCodec(key);

    assertion(codec != null, 'Codec for $key not found');

    return MapEntry(key, codec!.decode(input));
  }
}
