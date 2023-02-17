// ignore_for_file: library_private_types_in_public_api

part of primitives;

class OptionCodec with Codec<OptionType> {
  final Codec subType;
  const OptionCodec(this.subType);

  @override
  void encodeTo(OptionType value, Output output) {
    if (value is NoneOption) {
      output.pushByte(0);
    } else if (value is Some) {
      output.pushByte(1);
      subType.encodeTo(value.value, output);
    } else {
      throw OptionException(
          'Unable to encode due to invalid value type. Needed value either Some() or None, but found of type: \'${value.runtimeType}\'.');
    }
  }

  @override
  OptionType decode(Input input) {
    final int b = input.read();
    switch (b) {
      case 0:
        return None;
      case 1:
        return Some(subType.decode(input));
      default:
        throw OptionException('Invalid Option Byte: $b');
    }
  }

  @override
  int sizeHint(OptionType value) {
    return 32;
  }
}

///
/// OptionType
///
/// OptionType is a generic type that can be either Some(T) or None.
class OptionType<T> extends Equatable {
  final String kind;
  final T? value;
  const OptionType(this.kind, [this.value]);

  @override
  List<Object?> get props => [kind, value];

  @override
  String toString() {
    return kind;
  }
}

///
/// Mocking as a None value similar to `rust type`.
const None = NoneOption();

class NoneOption extends OptionType implements EquatableMixin {
  const NoneOption() : super('None');

  @override
  List<Object?> get props => ['None'];

  @override
  String toString() {
    return 'None';
  }

  ///
  /// Convert to json
  ///
  /// Example:
  ///
  /// ```
  /// None.toJson() => {'_kind': 'None'}
  /// ```
  Map<String, dynamic> toJson() {
    return {
      '_kind': kind,
    };
  }
}

///
/// Mocking to get Some wrapped value inside Some(value);
class Some<T> extends OptionType<T> implements EquatableMixin {
  @override
  final T value;
  const Some(this.value) : super('Some');

  @override
  List<Object?> get props => ['Some', value];

  @override
  core.Type get runtimeType => value.runtimeType;

  @override
  String toString() {
    return 'Some(${value.toString()})';
  }

  ///
  /// Convert to json
  ///
  /// If the value is Some, then convert the value to json
  ///
  /// Example:
  ///
  /// ```
  /// Some(Some(1)).toJson() => {'_kind': 'Some', 'value': {'_kind': 'Some', 'value': 1}}
  ///
  /// Some(None).toJson() => {'_kind': 'Some', 'value': {'_kind': 'None'}}
  /// ```
  Map<String, dynamic> toJson() {
    return {
      '_kind': kind,
      'value': value is Some
          ? (value as Some).toJson()
          : (value == None ? None.toJson() : value),
    };
  }

  ///
  /// Create Some Object from the json
  ///
  /// Example:
  ///
  /// ```
  /// Some.fromJson({'_kind': 'Some', 'value': {'_kind': 'Some', 'value': 1}}) => Some(Some(1))
  ///
  /// Some.fromJson({'_kind': 'Some', 'value': {'_kind': 'None'}}) => Some(None)
  /// ```
  static Some fromJson(Map<String, dynamic> json) {
    if (json['_kind'] == 'Some' && json['value'] is Map<String, dynamic>) {
      return Some.fromJson(json['value']);
    } else if (json['_kind'] == 'None') {
      return Some(NoneOption());
    }
    return Some(json['value']);
  }
}
