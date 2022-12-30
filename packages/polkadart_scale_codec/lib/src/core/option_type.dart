// ignore_for_file: annotate_overrides

part of polkadart_scale_codec_core;

///
/// Making Option private and hence only `Some()` and `None` will be exposed for usage
class _Option<T> extends Equatable {
  final String kind;
  final T? value;
  const _Option(this.kind, [this.value]);

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

class NoneOption extends _Option implements EquatableMixin {
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
class Some<T> extends _Option implements EquatableMixin {
  final T value;
  const Some(this.value) : super('Some', value);

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
