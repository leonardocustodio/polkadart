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
}
