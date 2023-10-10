// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../sp_authority_discovery/app/public.dart' as _i4;
import 'assignment_app/public.dart' as _i5;
import 'indexed_vec_1.dart' as _i3;
import 'indexed_vec_2.dart' as _i6;
import 'validator_app/public.dart' as _i9;
import 'validator_index.dart' as _i2;

class SessionInfo {
  const SessionInfo({
    required this.activeValidatorIndices,
    required this.randomSeed,
    required this.disputePeriod,
    required this.validators,
    required this.discoveryKeys,
    required this.assignmentKeys,
    required this.validatorGroups,
    required this.nCores,
    required this.zerothDelayTrancheWidth,
    required this.relayVrfModuloSamples,
    required this.nDelayTranches,
    required this.noShowSlots,
    required this.neededApprovals,
  });

  factory SessionInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<ValidatorIndex>
  final List<_i2.ValidatorIndex> activeValidatorIndices;

  /// [u8; 32]
  final List<int> randomSeed;

  /// SessionIndex
  final int disputePeriod;

  /// IndexedVec<ValidatorIndex, ValidatorId>
  final _i3.IndexedVec validators;

  /// Vec<AuthorityDiscoveryId>
  final List<_i4.Public> discoveryKeys;

  /// Vec<AssignmentId>
  final List<_i5.Public> assignmentKeys;

  /// IndexedVec<GroupIndex, Vec<ValidatorIndex>>
  final _i6.IndexedVec validatorGroups;

  /// u32
  final int nCores;

  /// u32
  final int zerothDelayTrancheWidth;

  /// u32
  final int relayVrfModuloSamples;

  /// u32
  final int nDelayTranches;

  /// u32
  final int noShowSlots;

  /// u32
  final int neededApprovals;

  static const $SessionInfoCodec codec = $SessionInfoCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'activeValidatorIndices':
            activeValidatorIndices.map((value) => value).toList(),
        'randomSeed': randomSeed.toList(),
        'disputePeriod': disputePeriod,
        'validators': validators.map((value) => value.toList()).toList(),
        'discoveryKeys': discoveryKeys.map((value) => value.toList()).toList(),
        'assignmentKeys':
            assignmentKeys.map((value) => value.toList()).toList(),
        'validatorGroups': validatorGroups
            .map((value) => value.map((value) => value).toList())
            .toList(),
        'nCores': nCores,
        'zerothDelayTrancheWidth': zerothDelayTrancheWidth,
        'relayVrfModuloSamples': relayVrfModuloSamples,
        'nDelayTranches': nDelayTranches,
        'noShowSlots': noShowSlots,
        'neededApprovals': neededApprovals,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SessionInfo &&
          _i8.listsEqual(
            other.activeValidatorIndices,
            activeValidatorIndices,
          ) &&
          _i8.listsEqual(
            other.randomSeed,
            randomSeed,
          ) &&
          other.disputePeriod == disputePeriod &&
          _i8.listsEqual(
            other.validators,
            validators,
          ) &&
          _i8.listsEqual(
            other.discoveryKeys,
            discoveryKeys,
          ) &&
          _i8.listsEqual(
            other.assignmentKeys,
            assignmentKeys,
          ) &&
          _i8.listsEqual(
            other.validatorGroups,
            validatorGroups,
          ) &&
          other.nCores == nCores &&
          other.zerothDelayTrancheWidth == zerothDelayTrancheWidth &&
          other.relayVrfModuloSamples == relayVrfModuloSamples &&
          other.nDelayTranches == nDelayTranches &&
          other.noShowSlots == noShowSlots &&
          other.neededApprovals == neededApprovals;

  @override
  int get hashCode => Object.hash(
        activeValidatorIndices,
        randomSeed,
        disputePeriod,
        validators,
        discoveryKeys,
        assignmentKeys,
        validatorGroups,
        nCores,
        zerothDelayTrancheWidth,
        relayVrfModuloSamples,
        nDelayTranches,
        noShowSlots,
        neededApprovals,
      );
}

class $SessionInfoCodec with _i1.Codec<SessionInfo> {
  const $SessionInfoCodec();

  @override
  void encodeTo(
    SessionInfo obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.ValidatorIndex>(_i2.ValidatorIndexCodec())
        .encodeTo(
      obj.activeValidatorIndices,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.randomSeed,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.disputePeriod,
      output,
    );
    const _i1.SequenceCodec<_i9.Public>(_i9.PublicCodec()).encodeTo(
      obj.validators,
      output,
    );
    const _i1.SequenceCodec<_i4.Public>(_i4.PublicCodec()).encodeTo(
      obj.discoveryKeys,
      output,
    );
    const _i1.SequenceCodec<_i5.Public>(_i5.PublicCodec()).encodeTo(
      obj.assignmentKeys,
      output,
    );
    const _i1.SequenceCodec<List<_i2.ValidatorIndex>>(
            _i1.SequenceCodec<_i2.ValidatorIndex>(_i2.ValidatorIndexCodec()))
        .encodeTo(
      obj.validatorGroups,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.nCores,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.zerothDelayTrancheWidth,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.relayVrfModuloSamples,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.nDelayTranches,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.noShowSlots,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.neededApprovals,
      output,
    );
  }

  @override
  SessionInfo decode(_i1.Input input) {
    return SessionInfo(
      activeValidatorIndices:
          const _i1.SequenceCodec<_i2.ValidatorIndex>(_i2.ValidatorIndexCodec())
              .decode(input),
      randomSeed: const _i1.U8ArrayCodec(32).decode(input),
      disputePeriod: _i1.U32Codec.codec.decode(input),
      validators:
          const _i1.SequenceCodec<_i9.Public>(_i9.PublicCodec()).decode(input),
      discoveryKeys:
          const _i1.SequenceCodec<_i4.Public>(_i4.PublicCodec()).decode(input),
      assignmentKeys:
          const _i1.SequenceCodec<_i5.Public>(_i5.PublicCodec()).decode(input),
      validatorGroups: const _i1.SequenceCodec<List<_i2.ValidatorIndex>>(
              _i1.SequenceCodec<_i2.ValidatorIndex>(_i2.ValidatorIndexCodec()))
          .decode(input),
      nCores: _i1.U32Codec.codec.decode(input),
      zerothDelayTrancheWidth: _i1.U32Codec.codec.decode(input),
      relayVrfModuloSamples: _i1.U32Codec.codec.decode(input),
      nDelayTranches: _i1.U32Codec.codec.decode(input),
      noShowSlots: _i1.U32Codec.codec.decode(input),
      neededApprovals: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SessionInfo obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.ValidatorIndex>(_i2.ValidatorIndexCodec())
            .sizeHint(obj.activeValidatorIndices);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(obj.randomSeed);
    size = size + _i1.U32Codec.codec.sizeHint(obj.disputePeriod);
    size = size + const _i3.IndexedVecCodec().sizeHint(obj.validators);
    size = size +
        const _i1.SequenceCodec<_i4.Public>(_i4.PublicCodec())
            .sizeHint(obj.discoveryKeys);
    size = size +
        const _i1.SequenceCodec<_i5.Public>(_i5.PublicCodec())
            .sizeHint(obj.assignmentKeys);
    size = size + const _i6.IndexedVecCodec().sizeHint(obj.validatorGroups);
    size = size + _i1.U32Codec.codec.sizeHint(obj.nCores);
    size = size + _i1.U32Codec.codec.sizeHint(obj.zerothDelayTrancheWidth);
    size = size + _i1.U32Codec.codec.sizeHint(obj.relayVrfModuloSamples);
    size = size + _i1.U32Codec.codec.sizeHint(obj.nDelayTranches);
    size = size + _i1.U32Codec.codec.sizeHint(obj.noShowSlots);
    size = size + _i1.U32Codec.codec.sizeHint(obj.neededApprovals);
    return size;
  }
}
