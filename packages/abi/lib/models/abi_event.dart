part of abi;

class AbiEvent {
  final String name;
  final Codec<dynamic> type;
  final int amountIndexed;
  final String? signatureTopic;

  const AbiEvent({
    required this.name,
    required this.type,
    required this.amountIndexed,
    this.signatureTopic,
  });
}
