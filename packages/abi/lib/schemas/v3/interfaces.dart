/// The 4 byte selector to identify constructors and messages
typedef Selector = String;

///
/// Represents the static storage layout of an ink! smart contract.
abstract class LayoutForPortableForm {
  static LayoutForPortableForm fromJson(dynamic json) {
    if (json['cell'] != null) {
      return CellLayoutForPortableForm.fromJson(json['cell']);
    } else if (json['hash'] != null) {
      return HashLayoutForPortableForm.fromJson(json['hash']);
    } else if (json['array'] != null) {
      return ArrayLayoutForPortableForm.fromJson(json['array']);
    } else if (json['struct'] != null) {
      return StructLayoutForPortableForm.fromJson(json['struct']);
    } else if (json['enum'] != null) {
      return EnumLayoutForPortableForm.fromJson(json['enum']);
    } else {
      throw Exception('LayoutForPortableForm is not a valid type');
    }
  }
}

///
/// One of the supported crypto hashers.
abstract class CryptoHasher {
  static CryptoHasher fromJson(dynamic json) {
    if (json == 'Blake2x256') {
      return CryptoHasher.Blake2x256;
    } else if (json == 'Sha2x256') {
      return CryptoHasher.Sha2x256;
    } else if (json == 'Keccak256') {
      return CryptoHasher.Keccak256;
    } else {
      throw Exception('CryptoHasher is not a valid type');
    }
  }
}

///
/// The possible types a SCALE encodable Rust value could have.
///
/// # Note
///
/// In order to preserve backwards compatibility, variant indices are explicitly specified instead of depending on the default implicit ordering.
///
/// When adding a new variant, it must be added at the end with an incremented index.
///
/// When removing an existing variant, the rest of variant indices remain the same, and the removed index should not be reused.
abstract class TypeDefForPortableForm {
  static TypeDefForPortableForm fromJson(dynamic json) {
    if (json['composite'] != null) {
      return TypeDefCompositeForPortableForm.fromJson(json['composite']);
    } else if (json['variant'] != null) {
      return TypeDefVariantForPortableForm.fromJson(json['variant']);
    } else if (json['sequence'] != null) {
      return TypeDefSequenceForPortableForm.fromJson(json['sequence']);
    } else if (json['array'] != null) {
      return TypeDefArrayForPortableForm.fromJson(json['array']);
    } else if (json['tuple'] != null) {
      return TypeDefTuple.fromJson(json['tuple']);
    } else if (json['primitive'] != null) {
      return TypeDefPrimitive.fromJson(json['primitive']);
    } else if (json['compact'] != null) {
      return TypeDefCompactForPortableForm.fromJson(json['compact']);
    } else if (json['bitsequence'] != null) {
      return TypeDefBitSequenceForPortableForm.fromJson(json['bitsequence']);
    } else {
      throw Exception('TypeDefForPortableForm is not a valid type');
    }
  }
}

///
/// Enum to represent a deprecated metadata version that cannot be instantiated.
class MetadataVersionDeprecated {
  static MetadataVersionDeprecated fromJson(dynamic json) {
    return MetadataVersionDeprecated();
  }
}

///
/// An entire ink! project for metadata file generation purposes.
class InkProject {
  final ContractSpecForPortableForm spec;

  /// The layout of the storage data structure
  final LayoutForPortableForm storage;
  final List<PortableType> types;

  InkProject({
    required this.spec,
    required this.storage,
    required this.types,
  });

  static InkProject fromJson(dynamic json) {
    return InkProject(
      spec: ContractSpecForPortableForm.fromJson(json['spec']),
      storage: LayoutForPortableForm.fromJson(json['storage']),
      types:
          (json['types'] as List).map((e) => PortableType.fromJson(e)).toList(),
    );
  }
}

///
/// Describes a contract.
class ContractSpecForPortableForm {
  final List<ConstructorSpecForPortableForm> constructors;
  final List<String> docs;
  final List<EventSpecForPortableForm> events;
  final List<MessageSpecForPortableForm> messages;

  ContractSpecForPortableForm({
    required this.constructors,
    required this.docs,
    required this.events,
    required this.messages,
  });

  static ContractSpecForPortableForm fromJson(dynamic json) {
    return ContractSpecForPortableForm(
      constructors: (json['constructors'] as List)
          .map((e) => ConstructorSpecForPortableForm.fromJson(e))
          .toList(),
      docs: (json['docs'] as List).map((e) => e as String).toList(),
      events: (json['events'] as List)
          .map((e) => EventSpecForPortableForm.fromJson(e))
          .toList(),
      messages: (json['messages'] as List)
          .map((e) => MessageSpecForPortableForm.fromJson(e))
          .toList(),
    );
  }
}

///
/// Describes a constructor of a contract.
class ConstructorSpecForPortableForm {
  final List<MessageParamSpecForPortableForm> args;
  final List<String> docs;
  final String label;
  final bool payable;
  final Selector selector;

  ConstructorSpecForPortableForm({
    required this.args,
    required this.docs,
    required this.label,
    required this.payable,
    required this.selector,
  });

  static ConstructorSpecForPortableForm fromJson(dynamic json) {
    return ConstructorSpecForPortableForm(
      args: (json['args'] as List)
          .map((e) => MessageParamSpecForPortableForm.fromJson(e))
          .toList(),
      docs: (json['docs'] as List).map((e) => e as String).toList(),
      label: json['label'] as String,
      payable: json['payable'] as bool,
      selector: json['selector'] as Selector,
    );
  }
}

///
/// Describes a pair of parameter label and type.
class MessageParamSpecForPortableForm {
  final String label;
  final TypeSpecForPortableForm type;

  MessageParamSpecForPortableForm({
    required this.label,
    required this.type,
  });

  static MessageParamSpecForPortableForm fromJson(dynamic json) {
    return MessageParamSpecForPortableForm(
      label: json['label'] as String,
      type: TypeSpecForPortableForm.fromJson(json['type']),
    );
  }
}
