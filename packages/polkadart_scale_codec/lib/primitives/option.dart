// ignore_for_file: library_private_types_in_public_api

part of primitives;

class OptionCodec with Codec<_OptionType> {
  final Codec? subType;
  const OptionCodec(this.subType);

  @override
  void encodeTo(_OptionType value, Output output) {
    if (value is NoneOption) {
      output.pushByte(0);
    } else if (value is Some) {
      output.pushByte(1);
      if (subType == null) {
        throw OptionException('Need to specify a subType for Some to encode.');
      }
      subType!.encodeTo(value.value, output);
    } else {
      throw OptionException(
          'Unable to encode due to invalid value type. Needed value either Some() or None, but found of type: \'${value.runtimeType}\'.');
    }
  }

  @override
  _OptionType decode(Input input) {
    final int b = input.read();
    switch (b) {
      case 0:
        return None;
      case 1:
        {
          //
          // A smart way to handle 2 case scenarios:
          //
          // Option<Option<bool>> : Some(Some(false)) : '0x010100'
          // Option<Option<bool>> : Some(None)        : '0x010100'
          //
          // See, It simplifies the things....
          if (subType is OptionCodec && input.peekByte() == 0) {
            return Some(None);
          }
          if (subType == null) {
            throw OptionException(
                'Need to specify a subType for Some to encode.');
          }
          return Some(subType!.decode(input));
        }
      default:
        throw OptionException('Invalid Option Byte: $b');
    }
  }

  @override
  int sizeHint(_OptionType value) {
    return 32;
  }
}

///
/// OptionType
///
/// OptionType is a generic type that can be either Some(T) or None.
class _OptionType<T> extends Equatable {
  final String kind;
  final T? value;
  const _OptionType(this.kind, [this.value]);

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

class NoneOption extends _OptionType implements EquatableMixin {
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
class Some<T> extends _OptionType implements EquatableMixin {
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