part of ink_abi;

class InkAbiEvent {
  final String name;
  final int type;
  final int amountIndexed;
  final String? signatureTopic;

  const InkAbiEvent({
    required this.name,
    required this.type,
    required this.amountIndexed,
    this.signatureTopic,
  });
}
