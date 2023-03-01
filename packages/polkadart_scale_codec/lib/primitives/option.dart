// ignore_for_file: library_private_types_in_public_api

part of primitives;

class OptionCodec with Codec<Option> {
  final Codec subType;
  const OptionCodec(this.subType);

  @override
  void encodeTo(Option value, Output output) {
    if (value.isNone) {
      output.pushByte(0);
    } else if (value.isSome) {
      output.pushByte(1);
      subType.encodeTo(value.value, output);
    } else {
      throw OptionException(
          'Unable to encode due to invalid value type. Needed value either Option.some() or None, but found of type: \'${value.runtimeType}\'.');
    }
  }

  @override
  Option decode(Input input) {
    final int b = input.read();
    switch (b) {
      case 0:
        return Option.none();
      case 1:
        return Option.some(subType.decode(input));
      default:
        throw OptionException('Invalid Option Byte: $b');
    }
  }
}

const None = Option.none();

class Option extends Equatable {
  final dynamic value;
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
  List<Object?> get props => [_isSome, value];
}
