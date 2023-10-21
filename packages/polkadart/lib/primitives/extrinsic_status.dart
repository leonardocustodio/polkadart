part of primitives;

// readonly isFuture: boolean;
// readonly isReady: boolean;
// readonly isBroadcast: boolean;
// readonly asBroadcast: Vec<Text>;
// readonly isInBlock: boolean;
// readonly asInBlock: Hash;
// readonly isRetracted: boolean;
// readonly asRetracted: Hash;
// readonly isFinalityTimeout: boolean;
// readonly asFinalityTimeout: Hash;
// readonly isFinalized: boolean;
// readonly asFinalized: Hash;
// readonly isUsurped: boolean;
// readonly asUsurped: Hash;
// readonly isDropped: boolean;
// readonly isInvalid: boolean;
// readonly type: 'Future' | 'Ready' | 'Broadcast' | 'InBlock' | 'Retracted' | 'FinalityTimeout' | 'Finalized' | 'Usurped' | 'Dropped' | 'Invalid';

class ExtrinsicStatus {
  const ExtrinsicStatus({
    required this.type,
    required this.value,
  });

  // factory ExtrinsicStatus.decode(Input input) {
  //   return codec.decode(input);
  // }

  factory ExtrinsicStatus.fromJson(dynamic json) {
    print('Json: $json');
    String type;
    dynamic value;

    if (json is String) {
      type = json;
      value = null;
    } else if (json is Map<String, dynamic>) {
      type = json.keys.first;
      value = json[type];
    } else {
      throw Exception('ExtrinsicStatus: Invalid json value "$json"');
    }

    return ExtrinsicStatus(
      type: type,
      value: value,
    );
  }

  final String type;
  final dynamic value;

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
