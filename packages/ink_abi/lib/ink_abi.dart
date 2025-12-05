library ink_abi;

// External package imports
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_schema/json_schema.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/substrate_metadata.dart';

part 'ink_abi.g.dart';

// Exception parts - base exception must be first
part 'exceptions/ink_abi_exception.dart';
part 'exceptions/type_resolution_exception.dart';
part 'exceptions/decoding_exception.dart';
part 'exceptions/encoding_exception.dart';

// Registry parts
part 'registry/ink_metadata_registry.dart';

// Model parts
part 'models/type_info.dart';
part 'models/type_spec.dart';
part 'models/arg_spec.dart';
part 'models/event_spec.dart';
part 'models/constructor_spec.dart';
part 'models/message_spec.dart';
part 'models/event_data.dart';

// Core parts
part 'core/selector_byte_input.dart';
part 'core/decode_result.dart';
part 'core/encode_call.dart';
part 'core/ink_abi.dart';

// Schema parts
part 'schemas/schema_validator.dart';
part 'schemas/v3/ink_v3_schema.dart';
part 'schemas/v4/ink_v4_schema.dart';
part 'schemas/v5/ink_v5_schema.dart';
