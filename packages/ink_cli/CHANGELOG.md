## 1.0.0

### Breaking Changes
- **Extrinsic building completely refactored** - Now uses polkadart's `ExtrinsicBuilder` instead of manual construction
- Removed `ContractExtrinsicPayload` class
- Removed `ContractSigningPayload` class
- Removed `ContractMeta` class
- Removed `/src/definitions/contracts.dart` (custom type definitions)
- `ContractsMethod.encode()` signature changed from `encode(Registry registry)` to `encode(ChainInfo chainInfo)`
- `ContractCallArgs.address` changed from `List<int>` to `Uint8List`
- `storageDepositLimit` changed from `Option` type to nullable `BigInt?`
- Import changed from `package:ink_abi/ink_abi_base.dart` to `package:ink_abi/ink_abi.dart`

### Added
- **`ContractsApiResponseCodec`** - Proper decoding of ContractsApi Runtime API responses
  - Supports both V14 and V15 metadata versions
  - V15 uses runtime API metadata via `registry.getRuntimeApiOutputCodec()`
  - V14 fallback to hardcoded known type structures from pallet-contracts-primitives
  - Handles `ContractsApi_instantiate` and `ContractsApi_call` responses
  - Custom exception type: `ContractsApiException`
- **`CodecInterface`** - New type system for code generation
  - `Primitive` enum with I8, U8, I16, U16, I32, U32, I64, U64, I128, U128, I256, U256, Bool, Str, Char
  - Base abstract class with `path` and `docs` properties
  - Implementations: `PrimitiveCodecInterface`, `CompositeCodecInterface`, `VariantCodecInterface`, `SequenceCodecInterface`, `ArrayCodecInterface`, `TupleCodecInterface`, `CompactCodecInterface`, `BitSequenceCodecInterface`, `OptionCodecInterface`

### Changed
- Uses `ExtrinsicBuilder.fromChainData()` for automatic extrinsic construction
- Uses `ChainDataFetcher` for automatic nonce fetching instead of manual `SystemApi` calls
- Uses `ChainInfo` instead of `ScaleCodec` for contract operations
- `ContractDeployer` and `ContractMutator` refactored to use `ChainInfo`
- Response decoding now uses `ContractsApiResponseCodec` for proper Runtime API response handling
- Enhanced pattern matching using Dart 3+ syntax (`case PrimitiveCodecInterface():` etc.)
- Improved struct generation: `_makeStruct()` now generates full Dart class definitions
- Enhanced variant generation: `_makeVariant()` generates sealed class hierarchies

### Removed
- Dependency on `package:ink_abi/interfaces/interfaces_base.dart`
- Dependency on `package:polkadart/substrate/era.dart`
- Dependency on `package:ss58/ss58.dart`
- Dependency on `package:substrate_metadata/utils/utils.dart`
- Dependency on `package:polkadart/scale_codec.dart`

## 0.3.1

## 0.3.0

 - Bump polkadart version to 0.7.0

## 0.2.3
- Improves state mutation for ink smart contracts

## 0.2.2
- General fixes for ink_cli

## 0.2.1
- Packages were bumped for new publish workflow

## 0.2.0
- All packages have been bumped to add web support

## 0.1.0
- Removes `json_schema2` from being a required dependency

## 0.0.1
- ink_cli initial version
