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
  /// None.toJson() => {'None': null}
  /// ```
  Map<String, dynamic> toJson() {
    return {'None': null};
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
  /// Some(Some(1)).toJson() => {'Some': {'Some': 1}}
  ///
  /// Some(None).toJson() => {'Some': {'None': null}}
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'Some': value is Some
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
  /// Some.fromJson({'Some': {'Some': 1}}) => Some(Some(1))
  ///
  /// Some.fromJson({'Some': {'None': null}}) => Some(None)
  /// ```
  static dynamic fromJson(Map<String, dynamic> json) {
    assertionCheck((json as Map<String, dynamic>).length == 1, 'Invalid json.');
    if (json.keys.first == 'Some') {
      if (json['Some'] is Map<String, dynamic>) {
        return Some(Some.fromJson(json['Some']));
      }
      return Some(json['Some']);
    } else if (json.keys.first == 'None') {
      return NoneOption();
    }
    throw UnexpectedCaseException('Expected to find Some or None key in json.');
  }
}
