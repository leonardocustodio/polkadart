part of multisig;

class Signatory {
  final Uint8List signatoryBytes;
  final String address;

  const Signatory(this.signatoryBytes, this.address);

  factory Signatory.fromAddress(String address) {
    return Signatory(Address.decode(address).pubkey, address);
  }

  factory Signatory.fromBytes(Uint8List bytes, int prefix) {
    return Signatory(bytes, Address(prefix: prefix, pubkey: bytes).encode());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Signatory &&
        (other.hashCode == hashCode ||
            other.signatoryBytes.toList(growable: false).toString() ==
                signatoryBytes.toList(growable: false).toString());
  }

  @override
  int get hashCode => signatoryBytes.toList(growable: false).toString().hashCode;
}
