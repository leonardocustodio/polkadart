part of codec_types;

///
/// Option
class Option<T> extends Codec<OptionType> {
  ///
  /// constructor
  Option._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of Option
  @override
  Option freshInstance() => Option._();

  ///
  /// Decodes the value from the Codec's input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('Option<(Compact<u8>, bool)>');
  /// final value = codec.decode(DefaultInput.fromHex('0x010c01'));
  /// print(value); // Some([3, true])
  /// print(value.value); // [3, true]
  /// ```
  @override
  OptionType decode(Input input) {
    final int b = input.byte();
    switch (b) {
      case 0:
        return None;
      case 1:
        assertionCheck(subType != null, 'SubType is not defined');

        //
        // A smart way to handle 2 case scenarios:
        //
        // Option<Option<bool>> : Some(Some(false)) : '0x010100'
        // Option<Option<bool>> : Some(None)        : '0x010100'
        //
        // See, It simplifies the things....
        if (subType is Option && input.peekByte() == 0) {
          return Some(None);
        }
        return Some(subType!.decode(input));
      default:
        throw InvalidOptionByteException(b);
    }
  }

  ///
  /// Encodes Option of values.
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('Option<(Compact<u8>, bool)>');
  /// final encoder = HexEncoder();
  /// final value = codec.encode(encoder, Some([3, true]));
  /// print(encoder.toHex()); // 0x010c01
  /// ```
  @override
  void encode(Encoder encoder, OptionType value) {
    if (value is NoneOption) {
      encoder.write(0);
    } else if (value is Some) {
      encoder.write(1);
      assertionCheck(subType != null, 'SubType is not defined');
      subType!.encode(encoder, value.value);
    } else {
      throw InvalidOptionException(
          'Unable to encode due to invalid value type. Needed value either Some() or None, but found of type: \'${value.runtimeType}\'.');
    }
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
class Some<T> extends OptionType implements EquatableMixin {
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
