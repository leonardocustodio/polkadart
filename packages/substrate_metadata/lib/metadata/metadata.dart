library metadata;

import 'dart:typed_data' show Uint8List;

import 'package:convert/convert.dart' show hex;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        Codec,
        CompactCodec,
        Input,
        OptionCodec,
        Output,
        SequenceCodec,
        StrCodec,
        U8Codec,
        U8SequenceCodec,
        U32Codec,
        ByteInput;
import 'package:polkadart_scale_codec/primitives/primitives.dart' show BTreeMapCodec, BoolCodec;
import 'package:substrate_metadata/utils/utils.dart';

// Common
part 'common/extrinsic_metadata.dart';
part 'common/field.dart';
part 'common/portable_type.dart';
part 'common/portable_type_def.dart';
part 'common/type_parameter.dart';
part 'common/variant_def.dart';
// Common -> Pallet
part 'common/pallet/pallet_call_metadata.dart';
part 'common/pallet/pallet_constant_metadata.dart';
part 'common/pallet/pallet_error_metadata.dart';
part 'common/pallet/pallet_event_metadata.dart';
part 'common/pallet/pallet_metadata.dart';
part 'common/pallet/pallet_storage_metadata.dart';
// Common -> Storage
part 'common/storage/storage_entry_metadata.dart';
part 'common/storage/storage_entry_modifier.dart';
part 'common/storage/storage_entry_type.dart';
part 'common/storage/storage_hasher.dart';
// Common -> TypeDefVariant
part 'common/type_def/type_def.dart';
part 'common/type_def/type_def_array.dart';
part 'common/type_def/type_def_compact.dart';
part 'common/type_def/type_def_composite.dart';
part 'common/type_def/type_def_primitive.dart';
part 'common/type_def/type_def_sequence.dart';
part 'common/type_def/type_def_tuple.dart';
part 'common/type_def/type_def_variant_type.dart';
part 'common/type_def/type_def_bit_sequence.dart';

//
// V14 -> Pallet
part 'v14/pallet/pallet_metadata_v14.dart';
// V14 -> Runtime
part 'runtime_metadata_prefixed.dart';
part 'v14/runtime/runtime_metadata_v14.dart';
// V14 -> Extrinsic
part 'v14/extrinsic_metadata_v14.dart';

//
// V15 -> Pallet
part 'v15/pallet/pallet_metadata_v15.dart';
// V15 -> Runtime
part 'v15/runtime/runtime_api_metadata_v15.dart';
part 'v15/runtime/runtime_metadata_v15.dart';
// V15 -> Extrinsic
part 'v15/extrinsic_metadata_v15.dart';
part 'v15/custom_metadata_v15.dart';

// V16
// V16 -> Pallet
part 'v16/pallet/pallet_metadata_v16.dart';
part 'v16/pallet/pallet_associated_type_metadata.dart';
// V16 -> Runtime
part 'v16/runtime/runtime_metadata_v16.dart';
part 'v16/runtime/runtime_api_metadata_v16.dart';
// V16 -> Extrinsics
part 'v16/extrinsic_metadata_v16.dart';
part 'v16/deprecation_info.dart';
