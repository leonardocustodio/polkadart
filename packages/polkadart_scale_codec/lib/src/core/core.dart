library polkadart_scale_codec_core;

/// imports
import 'dart:math';
import 'dart:mirrors';
import 'dart:typed_data';
import 'package:utility/utility.dart';
import 'package:equatable/equatable.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'dart:convert';

/// part files
part 'codec_type.dart';
part 'codec_variant.dart';
part 'codec.dart';
part 'source.dart';
part 'encoder.dart';
part 'type_kind.dart';
part 'types_codec.dart';
part 'types.dart';
part 'type_exp.dart';
part 'registry.dart';

// `Scale Codec` types
part '../types/codec_u8.dart';
part '../types/codec_u16.dart';
part '../types/codec_u32.dart';
part '../types/codec_u64.dart';
part '../types/codec_u128.dart';
part '../types/codec_u256.dart';
part '../types/codec_i8.dart';
part '../types/codec_i16.dart';
