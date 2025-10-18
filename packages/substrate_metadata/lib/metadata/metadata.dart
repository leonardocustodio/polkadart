library metadata;

import 'dart:typed_data' show Uint8List;

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
        U32Codec;

// Common
part 'common/field.dart';
part 'common/portable_registry.dart';
part 'common/portable_type.dart';
part 'common/type_def.dart';
part 'common/type_parameter.dart';
part 'common/variant_def.dart';
// Common -> TypeDefVariant
part 'common/type_def_variant/type_def_variant.dart';
part 'common/type_def_variant/type_def_array.dart';
part 'common/type_def_variant/type_def_compact.dart';
part 'common/type_def_variant/type_def_composite.dart';
part 'common/type_def_variant/type_def_primitive.dart';
part 'common/type_def_variant/type_def_sequence.dart';
part 'common/type_def_variant/type_def_tuple.dart';
part 'common/type_def_variant/type_def_variant_type.dart';
part 'common/type_def_variant/type_def_bit_sequence.dart';

// V14 -> Pallet
part 'v14/pallet/pallet_call_metadata_v14.dart';
part 'v14/pallet/pallet_constant_metadata_v14.dart';
part 'v14/pallet/pallet_error_metadata_v14.dart';
part 'v14/pallet/pallet_event_metadata_v14.dart';
part 'v14/pallet/pallet_metadata_v14.dart';
part 'v14/pallet/pallet_storage_metadata_v14.dart';
// V14 -> Runtime
part 'runtime_metadata_prefixed.dart';
part 'v14/runtime/runtime_metadata_v14.dart';
// V14 -> Storage
part 'v14/storage/storage_entry_metadata_v14.dart';
part 'v14/storage/storage_entry_type_v14.dart';
// V14 -> Extrinsic
part 'v14/extrinsic_metadata_v14.dart';
part 'v14/signed_extension_metadata_v14.dart';

//
// V15 -> Pallet
part 'v15/pallet/pallet_call_metadata_v15.dart';
part 'v15/pallet/pallet_constant_metadata_v15.dart';
part 'v15/pallet/pallet_error_metadata_v15.dart';
part 'v15/pallet/pallet_event_metadata_v15.dart';
part 'v15/pallet/pallet_metadata_v15.dart';
part 'v15/pallet/pallet_storage_metadata_v15.dart';
// V15 -> Runtime
part 'v15/runtime/runtime_api_metadata_v15.dart';
part 'v15/runtime/runtime_metadata_v15.dart';
// V15 -> Storage
part 'v15/storage/storage_entry_metadata_v15.dart';
// V15 -> Extrinsic
part 'v15/extrinsic_metadata_v15.dart';
