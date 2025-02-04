// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i8;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i9;

import '../polkadot_primitives/v7/assignment_app/public.dart' as _i5;
import '../polkadot_primitives/v7/validator_app/public.dart' as _i4;
import '../sp_authority_discovery/app/public.dart' as _i6;
import '../sp_consensus_babe/app/public.dart' as _i3;
import '../sp_consensus_beefy/ecdsa_crypto/public.dart' as _i7;
import '../sp_consensus_grandpa/app/public.dart' as _i2;

class SessionKeys {
  const SessionKeys({
    required this.grandpa,
    required this.babe,
    required this.paraValidator,
    required this.paraAssignment,
    required this.authorityDiscovery,
    required this.beefy,
  });

  factory SessionKeys.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// <Grandpa as $crate::BoundToRuntimeAppPublic>::Public
  final _i2.Public grandpa;

  /// <Babe as $crate::BoundToRuntimeAppPublic>::Public
  final _i3.Public babe;

  /// <Initializer as $crate::BoundToRuntimeAppPublic>::Public
  final _i4.Public paraValidator;

  /// <ParaSessionInfo as $crate::BoundToRuntimeAppPublic>::Public
  final _i5.Public paraAssignment;

  /// <AuthorityDiscovery as $crate::BoundToRuntimeAppPublic>::Public
  final _i6.Public authorityDiscovery;

  /// <Beefy as $crate::BoundToRuntimeAppPublic>::Public
  final _i7.Public beefy;

  static const $SessionKeysCodec codec = $SessionKeysCodec();

  _i8.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>> toJson() => {
        'grandpa': grandpa.toList(),
        'babe': babe.toList(),
        'paraValidator': paraValidator.toList(),
        'paraAssignment': paraAssignment.toList(),
        'authorityDiscovery': authorityDiscovery.toList(),
        'beefy': beefy.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SessionKeys &&
          _i9.listsEqual(
            other.grandpa,
            grandpa,
          ) &&
          _i9.listsEqual(
            other.babe,
            babe,
          ) &&
          _i9.listsEqual(
            other.paraValidator,
            paraValidator,
          ) &&
          _i9.listsEqual(
            other.paraAssignment,
            paraAssignment,
          ) &&
          _i9.listsEqual(
            other.authorityDiscovery,
            authorityDiscovery,
          ) &&
          _i9.listsEqual(
            other.beefy,
            beefy,
          );

  @override
  int get hashCode => Object.hash(
        grandpa,
        babe,
        paraValidator,
        paraAssignment,
        authorityDiscovery,
        beefy,
      );
}

class $SessionKeysCodec with _i1.Codec<SessionKeys> {
  const $SessionKeysCodec();

  @override
  void encodeTo(
    SessionKeys obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.grandpa,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.babe,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.paraValidator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.paraAssignment,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.authorityDiscovery,
      output,
    );
    const _i1.U8ArrayCodec(33).encodeTo(
      obj.beefy,
      output,
    );
  }

  @override
  SessionKeys decode(_i1.Input input) {
    return SessionKeys(
      grandpa: const _i1.U8ArrayCodec(32).decode(input),
      babe: const _i1.U8ArrayCodec(32).decode(input),
      paraValidator: const _i1.U8ArrayCodec(32).decode(input),
      paraAssignment: const _i1.U8ArrayCodec(32).decode(input),
      authorityDiscovery: const _i1.U8ArrayCodec(32).decode(input),
      beefy: const _i1.U8ArrayCodec(33).decode(input),
    );
  }

  @override
  int sizeHint(SessionKeys obj) {
    int size = 0;
    size = size + const _i2.PublicCodec().sizeHint(obj.grandpa);
    size = size + const _i3.PublicCodec().sizeHint(obj.babe);
    size = size + const _i4.PublicCodec().sizeHint(obj.paraValidator);
    size = size + const _i5.PublicCodec().sizeHint(obj.paraAssignment);
    size = size + const _i6.PublicCodec().sizeHint(obj.authorityDiscovery);
    size = size + const _i7.PublicCodec().sizeHint(obj.beefy);
    return size;
  }
}
