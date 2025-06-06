part of ink_abi;

const inkV3Schema = {
  '\$schema': 'http://json-schema.org/draft-07/schema#',
  'title': 'MetadataVersioned',
  'description':
      'Versioned ink! project metadata.\n\n# Note\n\nRepresents the version of the serialized metadata *format*, which is distinct from the version of this crate for Rust semantic versioning compatibility.',
  'oneOf': [
    {
      'description':
          'Version 0 placeholder. Represents the original non-versioned metadata format.',
      'type': 'object',
      'required': ['V0'],
      'properties': {
        'V0': {'\$ref': '#/definitions/MetadataVersionDeprecated'}
      }
    },
    {
      'description': 'Version 1 of the contract metadata.',
      'type': 'object',
      'required': ['V1'],
      'properties': {
        'V1': {'\$ref': '#/definitions/MetadataVersionDeprecated'}
      }
    },
    {
      'description': 'Version 2 of the contract metadata.',
      'type': 'object',
      'required': ['V2'],
      'properties': {
        'V2': {'\$ref': '#/definitions/MetadataVersionDeprecated'}
      }
    },
    {
      'description': 'Version 3 of the contract metadata.',
      'type': 'object',
      'required': ['V3'],
      'properties': {
        'V3': {'\$ref': '#/definitions/InkProject'}
      }
    }
  ],
  'definitions': {
    'ArrayLayout_for_PortableForm': {
      'description': 'A layout for an array of associated cells with the same encoding.',
      'type': 'object',
      'required': ['cellsPerElem', 'layout', 'len', 'offset'],
      'properties': {
        'cellsPerElem': {
          'description': 'The number of cells each element in the array layout consists of.',
          'type': 'integer',
          'format': 'uint64',
          'minimum': 0.0
        },
        'layout': {
          'description': 'The layout of the elements stored in the array layout.',
          'allOf': [
            {'\$ref': '#/definitions/Layout_for_PortableForm'}
          ]
        },
        'len': {
          'description': 'The number of elements in the array layout.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        },
        'offset': {
          'description':
              'The offset key of the array layout.\n\nThis is the same key as the element at index 0 of the array layout.',
          'allOf': [
            {'\$ref': '#/definitions/LayoutKey'}
          ]
        }
      }
    },
    'CellLayout_for_PortableForm': {
      'description': 'A SCALE encoded cell.',
      'type': 'object',
      'required': ['key', 'ty'],
      'properties': {
        'key': {'description': 'The offset key into the storage.', 'type': 'string'},
        'ty': {
          'description': 'The type of the encoded entity.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'ConstructorSpec_for_PortableForm': {
      'description': 'Describes a constructor of a contract.',
      'type': 'object',
      'required': ['args', 'docs', 'label', 'payable', 'selector'],
      'properties': {
        'args': {
          'description': 'The parameters of the deployment handler.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/MessageParamSpec_for_PortableForm'}
        },
        'docs': {
          'description': 'The deployment handler documentation.',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'label': {
          'description':
              'The label of the constructor.\n\nIn case of a trait provided constructor the label is prefixed with the trait label.',
          'type': 'string'
        },
        'payable': {
          'description': 'If the constructor accepts any `value` from the caller.',
          'type': 'boolean'
        },
        'selector': {
          'description': 'The selector hash of the message.',
          'allOf': [
            {'\$ref': '#/definitions/Selector'}
          ]
        }
      }
    },
    'ContractSpec_for_PortableForm': {
      'description': 'Describes a contract.',
      'type': 'object',
      'required': ['constructors', 'docs', 'events', 'messages'],
      'properties': {
        'constructors': {
          'description': 'The set of constructors of the contract.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/ConstructorSpec_for_PortableForm'}
        },
        'docs': {
          'description': 'The contract documentation.',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'events': {
          'description': 'The events of the contract.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/EventSpec_for_PortableForm'}
        },
        'messages': {
          'description': 'The external messages of the contract.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/MessageSpec_for_PortableForm'}
        }
      }
    },
    'CryptoHasher': {
      'description': 'One of the supported crypto hashers.',
      'type': 'string',
      'enum': ['Blake2x256', 'Sha2x256', 'Keccak256']
    },
    'EnumLayout_for_PortableForm': {
      'description': 'An enum storage layout.',
      'type': 'object',
      'required': ['dispatchKey', 'variants'],
      'properties': {
        'dispatchKey': {
          'description': 'The key where the discriminant is stored to dispatch the variants.',
          'type': 'string'
        },
        'variants': {
          'description': 'The variants of the enum.',
          'type': 'object',
          'additionalProperties': {'\$ref': '#/definitions/StructLayout_for_PortableForm'}
        }
      }
    },
    'EventParamSpec_for_PortableForm': {
      'description': 'Describes a pair of parameter label and type.',
      'type': 'object',
      'required': ['docs', 'indexed', 'label', 'type'],
      'properties': {
        'docs': {
          'description': 'The documentation associated with the arguments.',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'indexed': {'description': 'If the event parameter is indexed.', 'type': 'boolean'},
        'label': {'description': 'The label of the parameter.', 'type': 'string'},
        'type': {
          'description': 'The type of the parameter.',
          'allOf': [
            {'\$ref': '#/definitions/TypeSpec_for_PortableForm'}
          ]
        }
      }
    },
    'EventSpec_for_PortableForm': {
      'description': 'Describes an event definition.',
      'type': 'object',
      'required': ['args', 'docs', 'label'],
      'properties': {
        'args': {
          'description': 'The event arguments.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/EventParamSpec_for_PortableForm'}
        },
        'docs': {
          'description': 'The event documentation.',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'label': {'description': 'The label of the event.', 'type': 'string'}
      }
    },
    'FieldLayout_for_PortableForm': {
      'description': 'The layout for a particular field of a struct layout.',
      'type': 'object',
      'required': ['layout'],
      'properties': {
        'layout': {
          'description':
              'The kind of the field.\n\nThis is either a direct layout bound or another recursive layout sub-struct.',
          'allOf': [
            {'\$ref': '#/definitions/Layout_for_PortableForm'}
          ]
        },
        'name': {
          'description':
              'The name of the field.\n\nCan be missing, e.g. in case of an enum tuple struct variant.',
          'type': ['string', 'null']
        }
      }
    },
    'Field_for_PortableForm': {
      'description':
          'A field of a struct-like data type.\n\nName is optional so it can represent both named and unnamed fields.\n\nThis can be a named field of a struct type or an enum struct variant, or an unnamed field of a tuple struct.\n\n# Type name\n\nThe `type_name` field contains a string which is the name of the type of the field as it appears in the source code. The exact contents and format of the type name are not specified, but in practice will be the name of any valid type for a field e.g.\n\n- Concrete types e.g `\'u32\'`, `\'bool\'`, `\'Foo\'` etc. - Type parameters e.g `\'T\'`, `\'U\'` - Generic types e.g `\'Vec<u32>\'`, `\'Vec<T>\'` - Associated types e.g. `\'T::MyType\'`, `\'<T as MyTrait>::MyType\'` - Type aliases e.g. `\'MyTypeAlias\'`, `\'MyTypeAlias<T>\'` - Other built in Rust types e.g. arrays, references etc.\n\nNote that the type name doesn\'t correspond to the underlying type of the field, unless using a concrete type directly. Any given type may be referred to by multiple field type names, when using generic type parameters and type aliases.\n\nThis is intended for informational and diagnostic purposes only. Although it is possible to infer certain properties e.g. whether a type name is a type alias, there are no guarantees provided, and the type name representation may change.',
      'type': 'object',
      'required': ['type'],
      'properties': {
        'docs': {
          'description': 'Documentation',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'name': {
          'description': 'The name of the field. None for unnamed fields.',
          'type': ['string', 'null']
        },
        'type': {
          'description': 'The type of the field.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        },
        'typeName': {
          'description': 'The name of the type of the field as it appears in the source code.',
          'type': ['string', 'null']
        }
      }
    },
    'HashLayout_for_PortableForm': {
      'description':
          'A hashing layout potentially hitting all cells of the storage.\n\nEvery hashing layout has an offset and a strategy to compute its keys.',
      'type': 'object',
      'required': ['layout', 'offset', 'strategy'],
      'properties': {
        'layout': {
          'description': 'The storage layout of the unbounded layout elements.',
          'allOf': [
            {'\$ref': '#/definitions/Layout_for_PortableForm'}
          ]
        },
        'offset': {
          'description': 'The key offset used by the strategy.',
          'allOf': [
            {'\$ref': '#/definitions/LayoutKey'}
          ]
        },
        'strategy': {
          'description': 'The hashing strategy to layout the underlying elements.',
          'allOf': [
            {'\$ref': '#/definitions/HashingStrategy'}
          ]
        }
      }
    },
    'HashingStrategy': {
      'description':
          'The unbounded hashing strategy.\n\nThe offset key is used as another postfix for the computation. So the actual formula is: `hasher(prefix + encoded(key) + offset + postfix)` Where `+` in this contexts means append of the byte slices.',
      'type': 'object',
      'required': ['hasher', 'postfix', 'prefix'],
      'properties': {
        'hasher': {
          'description': 'One of the supported crypto hashers.',
          'allOf': [
            {'\$ref': '#/definitions/CryptoHasher'}
          ]
        },
        'postfix': {
          'description': 'An optional postfix to the computed hash.',
          'type': 'array',
          'items': {'type': 'integer', 'format': 'uint8', 'minimum': 0.0}
        },
        'prefix': {
          'description': 'An optional prefix to the computed hash.',
          'type': 'array',
          'items': {'type': 'integer', 'format': 'uint8', 'minimum': 0.0}
        }
      }
    },
    'InkProject': {
      'description': 'An entire ink! project for metadata file generation purposes.',
      'type': 'object',
      'required': ['spec', 'storage', 'types'],
      'properties': {
        'spec': {'\$ref': '#/definitions/ContractSpec_for_PortableForm'},
        'storage': {
          'description': 'The layout of the storage data structure',
          'allOf': [
            {'\$ref': '#/definitions/Layout_for_PortableForm'}
          ]
        },
        'types': {
          'type': 'array',
          'items': {'\$ref': '#/definitions/PortableType'}
        }
      }
    },
    'LayoutKey': {
      'description': 'A pointer into some storage region.',
      'type': 'object',
      'required': ['key'],
      'properties': {
        'key': {
          'type': 'array',
          'items': {'type': 'integer', 'format': 'uint8', 'minimum': 0.0},
          'maxItems': 32,
          'minItems': 32
        }
      }
    },
    'Layout_for_PortableForm': {
      'description': 'Represents the static storage layout of an ink! smart contract.',
      'oneOf': [
        {
          'description':
              'An encoded cell.\n\nThis is the only leaf node within the layout graph. All layout nodes have this node type as their leafs.\n\nThis represents the encoding of a single cell mapped to a single key.',
          'type': 'object',
          'required': ['cell'],
          'properties': {
            'cell': {'\$ref': '#/definitions/CellLayout_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description':
              'A layout that hashes values into the entire storage key space.\n\nThis is commonly used by ink! hashmaps and similar data structures.',
          'type': 'object',
          'required': ['hash'],
          'properties': {
            'hash': {'\$ref': '#/definitions/HashLayout_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description':
              'An array of associated storage cells encoded with a given type.\n\nThis can also represent only a single cell.',
          'type': 'object',
          'required': ['array'],
          'properties': {
            'array': {'\$ref': '#/definitions/ArrayLayout_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'A struct layout with fields of different types.',
          'type': 'object',
          'required': ['struct'],
          'properties': {
            'struct': {'\$ref': '#/definitions/StructLayout_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'An enum layout with a discriminant telling which variant is layed out.',
          'type': 'object',
          'required': ['enum'],
          'properties': {
            'enum': {'\$ref': '#/definitions/EnumLayout_for_PortableForm'}
          },
          'additionalProperties': false
        }
      ]
    },
    'MessageParamSpec_for_PortableForm': {
      'description': 'Describes a pair of parameter label and type.',
      'type': 'object',
      'required': ['label', 'type'],
      'properties': {
        'label': {'description': 'The label of the parameter.', 'type': 'string'},
        'type': {
          'description': 'The type of the parameter.',
          'allOf': [
            {'\$ref': '#/definitions/TypeSpec_for_PortableForm'}
          ]
        }
      }
    },
    'MessageSpec_for_PortableForm': {
      'description': 'Describes a contract message.',
      'type': 'object',
      'required': ['args', 'docs', 'label', 'mutates', 'payable', 'selector'],
      'properties': {
        'args': {
          'description': 'The parameters of the message.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/MessageParamSpec_for_PortableForm'}
        },
        'docs': {
          'description': 'The message documentation.',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'label': {
          'description':
              'The label of the message.\n\nIn case of trait provided messages and constructors the prefix by convention in ink! is the label of the trait.',
          'type': 'string'
        },
        'mutates': {
          'description': 'If the message is allowed to mutate the contract state.',
          'type': 'boolean'
        },
        'payable': {
          'description': 'If the message accepts any `value` from the caller.',
          'type': 'boolean'
        },
        'returnType': {
          'description': 'The return type of the message.',
          'anyOf': [
            {'\$ref': '#/definitions/TypeSpec_for_PortableForm'},
            {'type': 'null'}
          ]
        },
        'selector': {
          'description': 'The selector hash of the message.',
          'allOf': [
            {'\$ref': '#/definitions/Selector'}
          ]
        }
      }
    },
    'MetadataVersionDeprecated': {
      'description': 'Enum to represent a deprecated metadata version that cannot be instantiated.',
      'type': 'object'
    },
    'PortableType': {
      'type': 'object',
      'required': ['id', 'type'],
      'properties': {
        'id': {'type': 'integer', 'format': 'uint32', 'minimum': 0.0},
        'type': {'\$ref': '#/definitions/Type_for_PortableForm'}
      }
    },
    'Selector': {
      'description': 'The 4 byte selector to identify constructors and messages',
      'type': 'string'
    },
    'StructLayout_for_PortableForm': {
      'description': 'A struct layout with consecutive fields of different layout.',
      'type': 'object',
      'required': ['fields'],
      'properties': {
        'fields': {
          'description': 'The fields of the struct layout.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/FieldLayout_for_PortableForm'}
        }
      }
    },
    'TypeDefArray_for_PortableForm': {
      'description': 'An array type.',
      'type': 'object',
      'required': ['len', 'type'],
      'properties': {
        'len': {
          'description': 'The length of the array type.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        },
        'type': {
          'description': 'The element type of the array type.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'TypeDefBitSequence_for_PortableForm': {
      'description':
          'Type describing a [`bitvec::vec::BitVec`].\n\n# Note\n\nThis can only be constructed for `TypeInfo` in the `MetaForm` with the `bit-vec` feature enabled, but can be decoded or deserialized into the `PortableForm` without this feature.',
      'type': 'object',
      'required': ['bit_order_type', 'bit_store_type'],
      'properties': {
        'bit_order_type': {
          'description': 'The type implementing [`bitvec::order::BitOrder`].',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        },
        'bit_store_type': {
          'description': 'The type implementing [`bitvec::store::BitStore`].',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'TypeDefCompact_for_PortableForm': {
      'description': 'A type wrapped in [`Compact`].',
      'type': 'object',
      'required': ['type'],
      'properties': {
        'type': {
          'description': 'The type wrapped in [`Compact`], i.e. the `T` in `Compact<T>`.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'TypeDefComposite_for_PortableForm': {
      'description':
          'A composite type, consisting of either named (struct) or unnamed (tuple struct) fields\n\n# Examples\n\n## A Rust struct with named fields.\n\n``` struct Person { name: String, age_in_years: u8, friends: Vec<Person>, } ```\n\n## A tuple struct with unnamed fields.\n\n``` struct Color(u8, u8, u8); ```\n\n## A so-called unit struct\n\n``` struct JustAMarker; ```',
      'type': 'object',
      'properties': {
        'fields': {
          'description': 'The fields of the composite type.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/Field_for_PortableForm'}
        }
      }
    },
    'TypeDefPrimitive': {
      'description':
          'A primitive Rust type.\n\n# Note\n\nExplicit codec indices specified to ensure backwards compatibility. See [`TypeDef`].',
      'type': 'string',
      'enum': [
        'bool',
        'char',
        'str',
        'u8',
        'u16',
        'u32',
        'u64',
        'u128',
        'u256',
        'i8',
        'i16',
        'i32',
        'i64',
        'i128',
        'i256'
      ]
    },
    'TypeDefSequence_for_PortableForm': {
      'description': 'A type to refer to a sequence of elements of the same type.',
      'type': 'object',
      'required': ['type'],
      'properties': {
        'type': {
          'description': 'The element type of the sequence type.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'TypeDefVariant_for_PortableForm': {
      'description':
          'A Enum type (consisting of variants).\n\n# Examples\n\n## A Rust enum, aka tagged union.\n\n``` enum MyEnum { RustAllowsForClikeVariants, AndAlsoForTupleStructs(i32, bool), OrStructs { with: i32, named: bool, fields: [u8; 32], }, ItIsntPossibleToSetADiscriminantThough, } ```\n\n## A C-like enum type.\n\n``` enum Days { Monday, Tuesday, Wednesday, Thursday = 42, // Allows setting the discriminant explicitly Friday, Saturday, Sunday, } ```\n\n## An empty enum (for marker purposes)\n\n``` enum JustAMarker {} ```',
      'type': 'object',
      'properties': {
        'variants': {
          'description': 'The variants of a variant type',
          'type': 'array',
          'items': {'\$ref': '#/definitions/Variant_for_PortableForm'}
        }
      }
    },
    'TypeDef_for_PortableForm': {
      'description':
          'The possible types a SCALE encodable Rust value could have.\n\n# Note\n\nIn order to preserve backwards compatibility, variant indices are explicitly specified instead of depending on the default implicit ordering.\n\nWhen adding a new variant, it must be added at the end with an incremented index.\n\nWhen removing an existing variant, the rest of variant indices remain the same, and the removed index should not be reused.',
      'oneOf': [
        {
          'description': 'A composite type (e.g. a struct or a tuple)',
          'type': 'object',
          'required': ['composite'],
          'properties': {
            'composite': {'\$ref': '#/definitions/TypeDefComposite_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'A variant type (e.g. an enum)',
          'type': 'object',
          'required': ['variant'],
          'properties': {
            'variant': {'\$ref': '#/definitions/TypeDefVariant_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'A sequence type with runtime known length.',
          'type': 'object',
          'required': ['sequence'],
          'properties': {
            'sequence': {'\$ref': '#/definitions/TypeDefSequence_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'An array type with compile-time known length.',
          'type': 'object',
          'required': ['array'],
          'properties': {
            'array': {'\$ref': '#/definitions/TypeDefArray_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'A tuple type.',
          'type': 'object',
          'required': ['tuple'],
          'properties': {
            'tuple': {
              'type': 'array',
              'items': {'type': 'integer', 'format': 'uint32', 'minimum': 0.0}
            }
          },
          'additionalProperties': false
        },
        {
          'description': 'A Rust primitive type.',
          'type': 'object',
          'required': ['primitive'],
          'properties': {
            'primitive': {'\$ref': '#/definitions/TypeDefPrimitive'}
          },
          'additionalProperties': false
        },
        {
          'description': 'A type using the [`Compact`] encoding',
          'type': 'object',
          'required': ['compact'],
          'properties': {
            'compact': {'\$ref': '#/definitions/TypeDefCompact_for_PortableForm'}
          },
          'additionalProperties': false
        },
        {
          'description': 'A type representing a sequence of bits.',
          'type': 'object',
          'required': ['bitsequence'],
          'properties': {
            'bitsequence': {'\$ref': '#/definitions/TypeDefBitSequence_for_PortableForm'}
          },
          'additionalProperties': false
        }
      ]
    },
    'TypeParameter_for_PortableForm': {
      'description': 'A generic type parameter.',
      'type': 'object',
      'required': ['name'],
      'properties': {
        'name': {
          'description': 'The name of the generic type parameter e.g. \'T\'.',
          'type': 'string'
        },
        'type': {
          'description':
              'The concrete type for the type parameter.\n\n`None` if the type parameter is skipped.',
          'type': ['integer', 'null'],
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'TypeSpec_for_PortableForm': {
      'description':
          'A type specification.\n\nThis contains the actual type as well as an optional compile-time known displayed representation of the type. This is useful for cases where the type is used through a type alias in order to provide information about the alias name.\n\n# Examples\n\nConsider the following Rust function: ```no_compile fn is_sorted(input: &[i32], pred: Predicate) -> bool; ``` In this above example `input` would have no displayable name, `pred`s display name is `Predicate` and the display name of the return type is simply `bool`. Note that `Predicate` could simply be a type alias to `fn(i32, i32) -> Ordering`.',
      'type': 'object',
      'required': ['displayName', 'type'],
      'properties': {
        'displayName': {
          'description': 'The compile-time known displayed representation of the type.',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'type': {
          'description': 'The actual type.',
          'type': 'integer',
          'format': 'uint32',
          'minimum': 0.0
        }
      }
    },
    'Type_for_PortableForm': {
      'description': 'A [`Type`] definition with optional metadata.',
      'type': 'object',
      'required': ['def'],
      'properties': {
        'def': {
          'description': 'The actual type definition',
          'allOf': [
            {'\$ref': '#/definitions/TypeDef_for_PortableForm'}
          ]
        },
        'docs': {
          'description': 'Documentation',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'params': {
          'description':
              'The generic type parameters of the type in use. Empty for non generic types',
          'type': 'array',
          'items': {'\$ref': '#/definitions/TypeParameter_for_PortableForm'}
        },
        'path': {
          'description': 'The unique path to the type. Can be empty for built-in types',
          'type': 'array',
          'items': {'type': 'string'}
        }
      }
    },
    'Variant_for_PortableForm': {
      'description':
          'A struct enum variant with either named (struct) or unnamed (tuple struct) fields.\n\n# Example\n\n``` enum Operation { Zero, //  ^^^^ this is a unit struct enum variant Add(i32, i32), //  ^^^^^^^^^^^^^ this is a tuple-struct enum variant Minus { source: i32 } //  ^^^^^^^^^^^^^^^^^^^^^ this is a struct enum variant } ```',
      'type': 'object',
      'required': ['index', 'name'],
      'properties': {
        'docs': {
          'description': 'Documentation',
          'type': 'array',
          'items': {'type': 'string'}
        },
        'fields': {
          'description': 'The fields of the variant.',
          'type': 'array',
          'items': {'\$ref': '#/definitions/Field_for_PortableForm'}
        },
        'index': {
          'description':
              'Index of the variant, used in `parity-scale-codec`.\n\nThe value of this will be, in order of precedence: 1. The explicit index defined by a `#[codec(index = N)]` attribute. 2. The implicit index from the position of the variant in the `enum` definition.',
          'type': 'integer',
          'format': 'uint8',
          'minimum': 0.0
        },
        'name': {'description': 'The name of the variant.', 'type': 'string'}
      }
    }
  }
};
