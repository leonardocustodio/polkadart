part of primitives;

class ExtrinsicStatus {
  const ExtrinsicStatus({
    required this.type,
    required this.value,
  });

  // factory ExtrinsicStatus.decode(Input input) {
  //   return codec.decode(input);
  // }

  factory ExtrinsicStatus.fromJson(Map<String, dynamic> json) {
    print('Inside status: $json');

    return ExtrinsicStatus(
      type: '',
      value: '',
    );
  }

  final String type;
  final String value;

  // Map<String, dynamic> toJson() => {
  //       'specName': specName,
  //       'implName': implName,
  //       'authoringVersion': authoringVersion,
  //       'specVersion': specVersion,
  //       'implVersion': implVersion,
  //       'apis': apis.map((value) => value.toJson()).toList(),
  //       'transactionVersion': transactionVersion,
  //       'stateVersion': stateVersion,
  //     };
  //
  // @override
  // bool operator ==(Object other) =>
  //     other is RuntimeVersion &&
  //     other.runtimeType == runtimeType &&
  //     other.specName == specName &&
  //
  // @override
  // int get hashCode => Object.hash(specName, implName, authoringVersion,
  //     specVersion, implName, apis, transactionVersion, stateVersion);
}
