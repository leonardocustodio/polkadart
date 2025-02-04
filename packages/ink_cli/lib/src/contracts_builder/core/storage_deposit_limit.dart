part of ink_cli;

class StorageDepositLimit {
  final BigInt? value;
  const StorageDepositLimit({this.value});

  Option toOption() {
    if (value != null) {
      return Option.some(value);
    }
    return Option.none();
  }
}
