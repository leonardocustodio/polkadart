library ink_abi;

import 'dart:typed_data' show Uint8List;

import 'package:ink_abi/exceptions/decoding_exception.dart';
import 'package:ink_abi/exceptions/encoding_exception.dart';
import 'package:ink_abi/exceptions/ink_abi_exception.dart';
import 'package:json_schema/json_schema.dart';
import 'package:ink_abi/models/arg_spec.dart' show ArgSpec;
import 'package:ink_abi/models/constructor_spec.dart';
import 'package:ink_abi/models/message_spec.dart';
import 'package:ink_abi/registry/ink_metadata_registry.dart' show InkMetadataRegistry;
import 'package:polkadart_scale_codec/core/core.dart' show Codec;
import 'package:polkadart_scale_codec/io/io.dart' show ByteInput, ByteOutput;
import 'package:polkadart_scale_codec/primitives/primitives.dart'
    show CompactCodec, StrCodec, U128Codec, U32Codec, U8Codec;
import 'package:polkadart_scale_codec/utils/utils.dart';

// Re-export core registry
export 'registry/ink_metadata_registry.dart';

// Models/Specs
export 'models/arg_spec.dart';
export 'models/constructor_spec.dart';
export 'models/event_spec.dart';
export 'models/message_spec.dart';
export 'models/type_spec.dart';

// Exceptions
export 'exceptions/ink_abi_exception.dart';
export 'exceptions/type_resolution_exception.dart';
export 'exceptions/encoding_exception.dart';
export 'exceptions/decoding_exception.dart';

// Core parts (must come after exports)
part 'core/ink_abi.dart';
part 'core/selector_byte_input.dart';
part 'core/encode_call.dart';
part 'core/decode_result.dart';

part 'schemas/schema_validator.dart';
part 'schemas/v3/ink_v3_schema.dart';
part 'schemas/v4/ink_v4_schema.dart';
part 'schemas/v5/ink_v5_schema.dart';
