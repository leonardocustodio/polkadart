// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../common/assignment.dart' as _i2;

class ParasEntry {
  const ParasEntry({
    required this.assignment,
    required this.availabilityTimeouts,
    required this.ttl,
  });

  factory ParasEntry.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Assignment
  final _i2.Assignment assignment;

  /// u32
  final int availabilityTimeouts;

  /// N
  final int ttl;

  static const $ParasEntryCodec codec = $ParasEntryCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'assignment': assignment.toJson(),
        'availabilityTimeouts': availabilityTimeouts,
        'ttl': ttl,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParasEntry &&
          other.assignment == assignment &&
          other.availabilityTimeouts == availabilityTimeouts &&
          other.ttl == ttl;

  @override
  int get hashCode => Object.hash(
        assignment,
        availabilityTimeouts,
        ttl,
      );
}

class $ParasEntryCodec with _i1.Codec<ParasEntry> {
  const $ParasEntryCodec();

  @override
  void encodeTo(
    ParasEntry obj,
    _i1.Output output,
  ) {
    _i2.Assignment.codec.encodeTo(
      obj.assignment,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.availabilityTimeouts,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.ttl,
      output,
    );
  }

  @override
  ParasEntry decode(_i1.Input input) {
    return ParasEntry(
      assignment: _i2.Assignment.codec.decode(input),
      availabilityTimeouts: _i1.U32Codec.codec.decode(input),
      ttl: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ParasEntry obj) {
    int size = 0;
    size = size + _i2.Assignment.codec.sizeHint(obj.assignment);
    size = size + _i1.U32Codec.codec.sizeHint(obj.availabilityTimeouts);
    size = size + _i1.U32Codec.codec.sizeHint(obj.ttl);
    return size;
  }
}
