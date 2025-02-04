// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_arithmetic/per_things/perbill.dart' as _i2;

class SchedulerParams {
  const SchedulerParams({
    required this.groupRotationFrequency,
    required this.parasAvailabilityPeriod,
    this.maxValidatorsPerCore,
    required this.lookahead,
    required this.numCores,
    required this.maxAvailabilityTimeouts,
    required this.onDemandQueueMaxSize,
    required this.onDemandTargetQueueUtilization,
    required this.onDemandFeeVariability,
    required this.onDemandBaseFee,
    required this.ttl,
  });

  factory SchedulerParams.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int groupRotationFrequency;

  /// BlockNumber
  final int parasAvailabilityPeriod;

  /// Option<u32>
  final int? maxValidatorsPerCore;

  /// u32
  final int lookahead;

  /// u32
  final int numCores;

  /// u32
  final int maxAvailabilityTimeouts;

  /// u32
  final int onDemandQueueMaxSize;

  /// Perbill
  final _i2.Perbill onDemandTargetQueueUtilization;

  /// Perbill
  final _i2.Perbill onDemandFeeVariability;

  /// Balance
  final BigInt onDemandBaseFee;

  /// BlockNumber
  final int ttl;

  static const $SchedulerParamsCodec codec = $SchedulerParamsCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'groupRotationFrequency': groupRotationFrequency,
        'parasAvailabilityPeriod': parasAvailabilityPeriod,
        'maxValidatorsPerCore': maxValidatorsPerCore,
        'lookahead': lookahead,
        'numCores': numCores,
        'maxAvailabilityTimeouts': maxAvailabilityTimeouts,
        'onDemandQueueMaxSize': onDemandQueueMaxSize,
        'onDemandTargetQueueUtilization': onDemandTargetQueueUtilization,
        'onDemandFeeVariability': onDemandFeeVariability,
        'onDemandBaseFee': onDemandBaseFee,
        'ttl': ttl,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SchedulerParams &&
          other.groupRotationFrequency == groupRotationFrequency &&
          other.parasAvailabilityPeriod == parasAvailabilityPeriod &&
          other.maxValidatorsPerCore == maxValidatorsPerCore &&
          other.lookahead == lookahead &&
          other.numCores == numCores &&
          other.maxAvailabilityTimeouts == maxAvailabilityTimeouts &&
          other.onDemandQueueMaxSize == onDemandQueueMaxSize &&
          other.onDemandTargetQueueUtilization ==
              onDemandTargetQueueUtilization &&
          other.onDemandFeeVariability == onDemandFeeVariability &&
          other.onDemandBaseFee == onDemandBaseFee &&
          other.ttl == ttl;

  @override
  int get hashCode => Object.hash(
        groupRotationFrequency,
        parasAvailabilityPeriod,
        maxValidatorsPerCore,
        lookahead,
        numCores,
        maxAvailabilityTimeouts,
        onDemandQueueMaxSize,
        onDemandTargetQueueUtilization,
        onDemandFeeVariability,
        onDemandBaseFee,
        ttl,
      );
}

class $SchedulerParamsCodec with _i1.Codec<SchedulerParams> {
  const $SchedulerParamsCodec();

  @override
  void encodeTo(
    SchedulerParams obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.groupRotationFrequency,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.parasAvailabilityPeriod,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.maxValidatorsPerCore,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.lookahead,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.numCores,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxAvailabilityTimeouts,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.onDemandQueueMaxSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.onDemandTargetQueueUtilization,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.onDemandFeeVariability,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.onDemandBaseFee,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.ttl,
      output,
    );
  }

  @override
  SchedulerParams decode(_i1.Input input) {
    return SchedulerParams(
      groupRotationFrequency: _i1.U32Codec.codec.decode(input),
      parasAvailabilityPeriod: _i1.U32Codec.codec.decode(input),
      maxValidatorsPerCore:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      lookahead: _i1.U32Codec.codec.decode(input),
      numCores: _i1.U32Codec.codec.decode(input),
      maxAvailabilityTimeouts: _i1.U32Codec.codec.decode(input),
      onDemandQueueMaxSize: _i1.U32Codec.codec.decode(input),
      onDemandTargetQueueUtilization: _i1.U32Codec.codec.decode(input),
      onDemandFeeVariability: _i1.U32Codec.codec.decode(input),
      onDemandBaseFee: _i1.U128Codec.codec.decode(input),
      ttl: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SchedulerParams obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.groupRotationFrequency);
    size = size + _i1.U32Codec.codec.sizeHint(obj.parasAvailabilityPeriod);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(obj.maxValidatorsPerCore);
    size = size + _i1.U32Codec.codec.sizeHint(obj.lookahead);
    size = size + _i1.U32Codec.codec.sizeHint(obj.numCores);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxAvailabilityTimeouts);
    size = size + _i1.U32Codec.codec.sizeHint(obj.onDemandQueueMaxSize);
    size = size +
        const _i2.PerbillCodec().sizeHint(obj.onDemandTargetQueueUtilization);
    size = size + const _i2.PerbillCodec().sizeHint(obj.onDemandFeeVariability);
    size = size + _i1.U128Codec.codec.sizeHint(obj.onDemandBaseFee);
    size = size + _i1.U32Codec.codec.sizeHint(obj.ttl);
    return size;
  }
}
