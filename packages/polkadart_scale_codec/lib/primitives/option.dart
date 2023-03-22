// ignore_for_file: library_private_types_in_public_api, hash_and_equals
part of primitives;

// Only necessary when Option<Option<T>>
class NestedOptionCodec<E> with Codec<Option<E>> {
  final Codec<E> subtypeCodec;

  const NestedOptionCodec(this.subtypeCodec);

  @override
  void encodeTo(Option<E> value, Output output) {
    if (value.isNone) {
      output.pushByte(0);
    } else {
      output.pushByte(1);
      subtypeCodec.encodeTo(value.value as E, output);
    }
  }

  @override
  Option<E> decode(Input input) {
    if (input.read() == 0) {
      return Option.none();
    }
    return Option.some(subtypeCodec.decode(input));
  }

  @override
  int sizeHint(Option<E> value) {
    if (value.isNone) {
      return 1;
    }
    return 1 + subtypeCodec.sizeHint(value.value as E);
  }
}

class OptionCodec<E> with Codec<E?> {
  final Codec<E> subtypeCodec;

  const OptionCodec(this.subtypeCodec);

  @override
  void encodeTo(E? value, Output output) {
    if (value == null) {
      output.pushByte(0);
    } else {
      output.pushByte(1);
      subtypeCodec.encodeTo(value, output);
    }
  }

  @override
  E? decode(Input input) {
    if (input.read() == 0) {
      return null;
    }
    return subtypeCodec.decode(input);
  }

  @override
  int sizeHint(E? value) {
    if (value == null) {
      return 1;
    }
    return 1 + subtypeCodec.sizeHint(value);
  }
}

const None = Option.none();

class Option<E> {
  final E? value;
  final bool _isSome; // Workaround for Option<int?>.some(null)

  const Option.some(this.value) : _isSome = true;
  const Option.none()
      : value = null,
        _isSome = false;

  bool get isSome => _isSome;
  bool get isNone => !_isSome;

  @override
  String toString() {
    if (_isSome) {
      return value.toString();
    }
    return 'null';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is Option) {
      if (other._isSome != _isSome) return false;
      if (other.value.runtimeType != value.runtimeType) return false;
      if (value is Equatable && other.value is Equatable) {
        final a = value as Equatable;
        final b = other.value as Equatable;
        return a == b;
      }
      if (value is List && other.value is List) {
        final a = value as List;
        final b = other.value as List;
        if (a.length != b.length) {
          return false;
        }
        for (int i = 0; i < a.length; i++) {
          if (a[i] != b[i]) return false;
        }
        return true;
      }
      return other.value == value;
    }

    return false;
  }
}
