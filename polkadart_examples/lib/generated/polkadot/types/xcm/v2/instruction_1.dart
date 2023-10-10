// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i13;

import '../double_encoded/double_encoded_1.dart' as _i8;
import 'instruction_1.dart' as _i14;
import 'multiasset/multi_asset.dart' as _i11;
import 'multiasset/multi_asset_filter.dart' as _i10;
import 'multiasset/multi_assets.dart' as _i3;
import 'multilocation/junctions.dart' as _i9;
import 'multilocation/multi_location.dart' as _i5;
import 'origin_kind.dart' as _i7;
import 'response.dart' as _i4;
import 'weight_limit.dart' as _i12;
import 'xcm_1.dart' as _i6;

abstract class Instruction {
  const Instruction();

  factory Instruction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $InstructionCodec codec = $InstructionCodec();

  static const $Instruction values = $Instruction();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Instruction {
  const $Instruction();

  WithdrawAsset withdrawAsset(_i3.MultiAssets value0) {
    return WithdrawAsset(value0);
  }

  ReserveAssetDeposited reserveAssetDeposited(_i3.MultiAssets value0) {
    return ReserveAssetDeposited(value0);
  }

  ReceiveTeleportedAsset receiveTeleportedAsset(_i3.MultiAssets value0) {
    return ReceiveTeleportedAsset(value0);
  }

  QueryResponse queryResponse({
    required BigInt queryId,
    required _i4.Response response,
    required BigInt maxWeight,
  }) {
    return QueryResponse(
      queryId: queryId,
      response: response,
      maxWeight: maxWeight,
    );
  }

  TransferAsset transferAsset({
    required _i3.MultiAssets assets,
    required _i5.MultiLocation beneficiary,
  }) {
    return TransferAsset(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  TransferReserveAsset transferReserveAsset({
    required _i3.MultiAssets assets,
    required _i5.MultiLocation dest,
    required _i6.Xcm xcm,
  }) {
    return TransferReserveAsset(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  Transact transact({
    required _i7.OriginKind originType,
    required BigInt requireWeightAtMost,
    required _i8.DoubleEncoded call,
  }) {
    return Transact(
      originType: originType,
      requireWeightAtMost: requireWeightAtMost,
      call: call,
    );
  }

  HrmpNewChannelOpenRequest hrmpNewChannelOpenRequest({
    required BigInt sender,
    required BigInt maxMessageSize,
    required BigInt maxCapacity,
  }) {
    return HrmpNewChannelOpenRequest(
      sender: sender,
      maxMessageSize: maxMessageSize,
      maxCapacity: maxCapacity,
    );
  }

  HrmpChannelAccepted hrmpChannelAccepted({required BigInt recipient}) {
    return HrmpChannelAccepted(recipient: recipient);
  }

  HrmpChannelClosing hrmpChannelClosing({
    required BigInt initiator,
    required BigInt sender,
    required BigInt recipient,
  }) {
    return HrmpChannelClosing(
      initiator: initiator,
      sender: sender,
      recipient: recipient,
    );
  }

  ClearOrigin clearOrigin() {
    return ClearOrigin();
  }

  DescendOrigin descendOrigin(_i9.Junctions value0) {
    return DescendOrigin(value0);
  }

  ReportError reportError({
    required BigInt queryId,
    required _i5.MultiLocation dest,
    required BigInt maxResponseWeight,
  }) {
    return ReportError(
      queryId: queryId,
      dest: dest,
      maxResponseWeight: maxResponseWeight,
    );
  }

  DepositAsset depositAsset({
    required _i10.MultiAssetFilter assets,
    required BigInt maxAssets,
    required _i5.MultiLocation beneficiary,
  }) {
    return DepositAsset(
      assets: assets,
      maxAssets: maxAssets,
      beneficiary: beneficiary,
    );
  }

  DepositReserveAsset depositReserveAsset({
    required _i10.MultiAssetFilter assets,
    required BigInt maxAssets,
    required _i5.MultiLocation dest,
    required _i6.Xcm xcm,
  }) {
    return DepositReserveAsset(
      assets: assets,
      maxAssets: maxAssets,
      dest: dest,
      xcm: xcm,
    );
  }

  ExchangeAsset exchangeAsset({
    required _i10.MultiAssetFilter give,
    required _i3.MultiAssets receive,
  }) {
    return ExchangeAsset(
      give: give,
      receive: receive,
    );
  }

  InitiateReserveWithdraw initiateReserveWithdraw({
    required _i10.MultiAssetFilter assets,
    required _i5.MultiLocation reserve,
    required _i6.Xcm xcm,
  }) {
    return InitiateReserveWithdraw(
      assets: assets,
      reserve: reserve,
      xcm: xcm,
    );
  }

  InitiateTeleport initiateTeleport({
    required _i10.MultiAssetFilter assets,
    required _i5.MultiLocation dest,
    required _i6.Xcm xcm,
  }) {
    return InitiateTeleport(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  QueryHolding queryHolding({
    required BigInt queryId,
    required _i5.MultiLocation dest,
    required _i10.MultiAssetFilter assets,
    required BigInt maxResponseWeight,
  }) {
    return QueryHolding(
      queryId: queryId,
      dest: dest,
      assets: assets,
      maxResponseWeight: maxResponseWeight,
    );
  }

  BuyExecution buyExecution({
    required _i11.MultiAsset fees,
    required _i12.WeightLimit weightLimit,
  }) {
    return BuyExecution(
      fees: fees,
      weightLimit: weightLimit,
    );
  }

  RefundSurplus refundSurplus() {
    return RefundSurplus();
  }

  SetErrorHandler setErrorHandler(_i6.Xcm value0) {
    return SetErrorHandler(value0);
  }

  SetAppendix setAppendix(_i6.Xcm value0) {
    return SetAppendix(value0);
  }

  ClearError clearError() {
    return ClearError();
  }

  ClaimAsset claimAsset({
    required _i3.MultiAssets assets,
    required _i5.MultiLocation ticket,
  }) {
    return ClaimAsset(
      assets: assets,
      ticket: ticket,
    );
  }

  Trap trap(BigInt value0) {
    return Trap(value0);
  }

  SubscribeVersion subscribeVersion({
    required BigInt queryId,
    required BigInt maxResponseWeight,
  }) {
    return SubscribeVersion(
      queryId: queryId,
      maxResponseWeight: maxResponseWeight,
    );
  }

  UnsubscribeVersion unsubscribeVersion() {
    return UnsubscribeVersion();
  }
}

class $InstructionCodec with _i1.Codec<Instruction> {
  const $InstructionCodec();

  @override
  Instruction decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return WithdrawAsset._decode(input);
      case 1:
        return ReserveAssetDeposited._decode(input);
      case 2:
        return ReceiveTeleportedAsset._decode(input);
      case 3:
        return QueryResponse._decode(input);
      case 4:
        return TransferAsset._decode(input);
      case 5:
        return TransferReserveAsset._decode(input);
      case 6:
        return Transact._decode(input);
      case 7:
        return HrmpNewChannelOpenRequest._decode(input);
      case 8:
        return HrmpChannelAccepted._decode(input);
      case 9:
        return HrmpChannelClosing._decode(input);
      case 10:
        return const ClearOrigin();
      case 11:
        return DescendOrigin._decode(input);
      case 12:
        return ReportError._decode(input);
      case 13:
        return DepositAsset._decode(input);
      case 14:
        return DepositReserveAsset._decode(input);
      case 15:
        return ExchangeAsset._decode(input);
      case 16:
        return InitiateReserveWithdraw._decode(input);
      case 17:
        return InitiateTeleport._decode(input);
      case 18:
        return QueryHolding._decode(input);
      case 19:
        return BuyExecution._decode(input);
      case 20:
        return const RefundSurplus();
      case 21:
        return SetErrorHandler._decode(input);
      case 22:
        return SetAppendix._decode(input);
      case 23:
        return const ClearError();
      case 24:
        return ClaimAsset._decode(input);
      case 25:
        return Trap._decode(input);
      case 26:
        return SubscribeVersion._decode(input);
      case 27:
        return const UnsubscribeVersion();
      default:
        throw Exception('Instruction: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Instruction value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case WithdrawAsset:
        (value as WithdrawAsset).encodeTo(output);
        break;
      case ReserveAssetDeposited:
        (value as ReserveAssetDeposited).encodeTo(output);
        break;
      case ReceiveTeleportedAsset:
        (value as ReceiveTeleportedAsset).encodeTo(output);
        break;
      case QueryResponse:
        (value as QueryResponse).encodeTo(output);
        break;
      case TransferAsset:
        (value as TransferAsset).encodeTo(output);
        break;
      case TransferReserveAsset:
        (value as TransferReserveAsset).encodeTo(output);
        break;
      case Transact:
        (value as Transact).encodeTo(output);
        break;
      case HrmpNewChannelOpenRequest:
        (value as HrmpNewChannelOpenRequest).encodeTo(output);
        break;
      case HrmpChannelAccepted:
        (value as HrmpChannelAccepted).encodeTo(output);
        break;
      case HrmpChannelClosing:
        (value as HrmpChannelClosing).encodeTo(output);
        break;
      case ClearOrigin:
        (value as ClearOrigin).encodeTo(output);
        break;
      case DescendOrigin:
        (value as DescendOrigin).encodeTo(output);
        break;
      case ReportError:
        (value as ReportError).encodeTo(output);
        break;
      case DepositAsset:
        (value as DepositAsset).encodeTo(output);
        break;
      case DepositReserveAsset:
        (value as DepositReserveAsset).encodeTo(output);
        break;
      case ExchangeAsset:
        (value as ExchangeAsset).encodeTo(output);
        break;
      case InitiateReserveWithdraw:
        (value as InitiateReserveWithdraw).encodeTo(output);
        break;
      case InitiateTeleport:
        (value as InitiateTeleport).encodeTo(output);
        break;
      case QueryHolding:
        (value as QueryHolding).encodeTo(output);
        break;
      case BuyExecution:
        (value as BuyExecution).encodeTo(output);
        break;
      case RefundSurplus:
        (value as RefundSurplus).encodeTo(output);
        break;
      case SetErrorHandler:
        (value as SetErrorHandler).encodeTo(output);
        break;
      case SetAppendix:
        (value as SetAppendix).encodeTo(output);
        break;
      case ClearError:
        (value as ClearError).encodeTo(output);
        break;
      case ClaimAsset:
        (value as ClaimAsset).encodeTo(output);
        break;
      case Trap:
        (value as Trap).encodeTo(output);
        break;
      case SubscribeVersion:
        (value as SubscribeVersion).encodeTo(output);
        break;
      case UnsubscribeVersion:
        (value as UnsubscribeVersion).encodeTo(output);
        break;
      default:
        throw Exception(
            'Instruction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Instruction value) {
    switch (value.runtimeType) {
      case WithdrawAsset:
        return (value as WithdrawAsset)._sizeHint();
      case ReserveAssetDeposited:
        return (value as ReserveAssetDeposited)._sizeHint();
      case ReceiveTeleportedAsset:
        return (value as ReceiveTeleportedAsset)._sizeHint();
      case QueryResponse:
        return (value as QueryResponse)._sizeHint();
      case TransferAsset:
        return (value as TransferAsset)._sizeHint();
      case TransferReserveAsset:
        return (value as TransferReserveAsset)._sizeHint();
      case Transact:
        return (value as Transact)._sizeHint();
      case HrmpNewChannelOpenRequest:
        return (value as HrmpNewChannelOpenRequest)._sizeHint();
      case HrmpChannelAccepted:
        return (value as HrmpChannelAccepted)._sizeHint();
      case HrmpChannelClosing:
        return (value as HrmpChannelClosing)._sizeHint();
      case ClearOrigin:
        return 1;
      case DescendOrigin:
        return (value as DescendOrigin)._sizeHint();
      case ReportError:
        return (value as ReportError)._sizeHint();
      case DepositAsset:
        return (value as DepositAsset)._sizeHint();
      case DepositReserveAsset:
        return (value as DepositReserveAsset)._sizeHint();
      case ExchangeAsset:
        return (value as ExchangeAsset)._sizeHint();
      case InitiateReserveWithdraw:
        return (value as InitiateReserveWithdraw)._sizeHint();
      case InitiateTeleport:
        return (value as InitiateTeleport)._sizeHint();
      case QueryHolding:
        return (value as QueryHolding)._sizeHint();
      case BuyExecution:
        return (value as BuyExecution)._sizeHint();
      case RefundSurplus:
        return 1;
      case SetErrorHandler:
        return (value as SetErrorHandler)._sizeHint();
      case SetAppendix:
        return (value as SetAppendix)._sizeHint();
      case ClearError:
        return 1;
      case ClaimAsset:
        return (value as ClaimAsset)._sizeHint();
      case Trap:
        return (value as Trap)._sizeHint();
      case SubscribeVersion:
        return (value as SubscribeVersion)._sizeHint();
      case UnsubscribeVersion:
        return 1;
      default:
        throw Exception(
            'Instruction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class WithdrawAsset extends Instruction {
  const WithdrawAsset(this.value0);

  factory WithdrawAsset._decode(_i1.Input input) {
    return WithdrawAsset(
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .decode(input));
  }

  /// MultiAssets
  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'WithdrawAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WithdrawAsset &&
          _i13.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ReserveAssetDeposited extends Instruction {
  const ReserveAssetDeposited(this.value0);

  factory ReserveAssetDeposited._decode(_i1.Input input) {
    return ReserveAssetDeposited(
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .decode(input));
  }

  /// MultiAssets
  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'ReserveAssetDeposited': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReserveAssetDeposited &&
          _i13.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ReceiveTeleportedAsset extends Instruction {
  const ReceiveTeleportedAsset(this.value0);

  factory ReceiveTeleportedAsset._decode(_i1.Input input) {
    return ReceiveTeleportedAsset(
        const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
            .decode(input));
  }

  /// MultiAssets
  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() => {
        'ReceiveTeleportedAsset': value0.map((value) => value.toJson()).toList()
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReceiveTeleportedAsset &&
          _i13.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class QueryResponse extends Instruction {
  const QueryResponse({
    required this.queryId,
    required this.response,
    required this.maxWeight,
  });

  factory QueryResponse._decode(_i1.Input input) {
    return QueryResponse(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      response: _i4.Response.codec.decode(input),
      maxWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt queryId;

  /// Response
  final _i4.Response response;

  /// u64
  final BigInt maxWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryResponse': {
          'queryId': queryId,
          'response': response.toJson(),
          'maxWeight': maxWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i4.Response.codec.sizeHint(response);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i4.Response.codec.encodeTo(
      response,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueryResponse &&
          other.queryId == queryId &&
          other.response == response &&
          other.maxWeight == maxWeight;

  @override
  int get hashCode => Object.hash(
        queryId,
        response,
        maxWeight,
      );
}

class TransferAsset extends Instruction {
  const TransferAsset({
    required this.assets,
    required this.beneficiary,
  });

  factory TransferAsset._decode(_i1.Input input) {
    return TransferAsset(
      assets: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
      beneficiary: _i5.MultiLocation.codec.decode(input),
    );
  }

  /// MultiAssets
  final _i3.MultiAssets assets;

  /// MultiLocation
  final _i5.MultiLocation beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferAsset &&
          _i13.listsEqual(
            other.assets,
            assets,
          ) &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        assets,
        beneficiary,
      );
}

class TransferReserveAsset extends Instruction {
  const TransferReserveAsset({
    required this.assets,
    required this.dest,
    required this.xcm,
  });

  factory TransferReserveAsset._decode(_i1.Input input) {
    return TransferReserveAsset(
      assets: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec)
          .decode(input),
    );
  }

  /// MultiAssets
  final _i3.MultiAssets assets;

  /// MultiLocation
  final _i5.MultiLocation dest;

  /// Xcm<()>
  final _i6.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferReserveAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + const _i6.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TransferReserveAsset &&
          _i13.listsEqual(
            other.assets,
            assets,
          ) &&
          other.dest == dest &&
          _i13.listsEqual(
            other.xcm,
            xcm,
          );

  @override
  int get hashCode => Object.hash(
        assets,
        dest,
        xcm,
      );
}

class Transact extends Instruction {
  const Transact({
    required this.originType,
    required this.requireWeightAtMost,
    required this.call,
  });

  factory Transact._decode(_i1.Input input) {
    return Transact(
      originType: _i7.OriginKind.codec.decode(input),
      requireWeightAtMost: _i1.CompactBigIntCodec.codec.decode(input),
      call: _i8.DoubleEncoded.codec.decode(input),
    );
  }

  /// OriginKind
  final _i7.OriginKind originType;

  /// u64
  final BigInt requireWeightAtMost;

  /// DoubleEncoded<RuntimeCall>
  final _i8.DoubleEncoded call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Transact': {
          'originType': originType.toJson(),
          'requireWeightAtMost': requireWeightAtMost,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.OriginKind.codec.sizeHint(originType);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(requireWeightAtMost);
    size = size + _i8.DoubleEncoded.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i7.OriginKind.codec.encodeTo(
      originType,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      requireWeightAtMost,
      output,
    );
    _i8.DoubleEncoded.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transact &&
          other.originType == originType &&
          other.requireWeightAtMost == requireWeightAtMost &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        originType,
        requireWeightAtMost,
        call,
      );
}

class HrmpNewChannelOpenRequest extends Instruction {
  const HrmpNewChannelOpenRequest({
    required this.sender,
    required this.maxMessageSize,
    required this.maxCapacity,
  });

  factory HrmpNewChannelOpenRequest._decode(_i1.Input input) {
    return HrmpNewChannelOpenRequest(
      sender: _i1.CompactBigIntCodec.codec.decode(input),
      maxMessageSize: _i1.CompactBigIntCodec.codec.decode(input),
      maxCapacity: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// u32
  final BigInt sender;

  /// u32
  final BigInt maxMessageSize;

  /// u32
  final BigInt maxCapacity;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'HrmpNewChannelOpenRequest': {
          'sender': sender,
          'maxMessageSize': maxMessageSize,
          'maxCapacity': maxCapacity,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(sender);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxMessageSize);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxCapacity);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      sender,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxMessageSize,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxCapacity,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpNewChannelOpenRequest &&
          other.sender == sender &&
          other.maxMessageSize == maxMessageSize &&
          other.maxCapacity == maxCapacity;

  @override
  int get hashCode => Object.hash(
        sender,
        maxMessageSize,
        maxCapacity,
      );
}

class HrmpChannelAccepted extends Instruction {
  const HrmpChannelAccepted({required this.recipient});

  factory HrmpChannelAccepted._decode(_i1.Input input) {
    return HrmpChannelAccepted(
        recipient: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt recipient;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'HrmpChannelAccepted': {'recipient': recipient}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(recipient);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      recipient,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpChannelAccepted && other.recipient == recipient;

  @override
  int get hashCode => recipient.hashCode;
}

class HrmpChannelClosing extends Instruction {
  const HrmpChannelClosing({
    required this.initiator,
    required this.sender,
    required this.recipient,
  });

  factory HrmpChannelClosing._decode(_i1.Input input) {
    return HrmpChannelClosing(
      initiator: _i1.CompactBigIntCodec.codec.decode(input),
      sender: _i1.CompactBigIntCodec.codec.decode(input),
      recipient: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// u32
  final BigInt initiator;

  /// u32
  final BigInt sender;

  /// u32
  final BigInt recipient;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'HrmpChannelClosing': {
          'initiator': initiator,
          'sender': sender,
          'recipient': recipient,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(initiator);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(sender);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(recipient);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      initiator,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      sender,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      recipient,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpChannelClosing &&
          other.initiator == initiator &&
          other.sender == sender &&
          other.recipient == recipient;

  @override
  int get hashCode => Object.hash(
        initiator,
        sender,
        recipient,
      );
}

class ClearOrigin extends Instruction {
  const ClearOrigin();

  @override
  Map<String, dynamic> toJson() => {'ClearOrigin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClearOrigin;

  @override
  int get hashCode => runtimeType.hashCode;
}

class DescendOrigin extends Instruction {
  const DescendOrigin(this.value0);

  factory DescendOrigin._decode(_i1.Input input) {
    return DescendOrigin(_i9.Junctions.codec.decode(input));
  }

  /// InteriorMultiLocation
  final _i9.Junctions value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'DescendOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Junctions.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i9.Junctions.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DescendOrigin && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ReportError extends Instruction {
  const ReportError({
    required this.queryId,
    required this.dest,
    required this.maxResponseWeight,
  });

  factory ReportError._decode(_i1.Input input) {
    return ReportError(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      maxResponseWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt queryId;

  /// MultiLocation
  final _i5.MultiLocation dest;

  /// u64
  final BigInt maxResponseWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ReportError': {
          'queryId': queryId,
          'dest': dest.toJson(),
          'maxResponseWeight': maxResponseWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxResponseWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxResponseWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportError &&
          other.queryId == queryId &&
          other.dest == dest &&
          other.maxResponseWeight == maxResponseWeight;

  @override
  int get hashCode => Object.hash(
        queryId,
        dest,
        maxResponseWeight,
      );
}

class DepositAsset extends Instruction {
  const DepositAsset({
    required this.assets,
    required this.maxAssets,
    required this.beneficiary,
  });

  factory DepositAsset._decode(_i1.Input input) {
    return DepositAsset(
      assets: _i10.MultiAssetFilter.codec.decode(input),
      maxAssets: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i5.MultiLocation.codec.decode(input),
    );
  }

  /// MultiAssetFilter
  final _i10.MultiAssetFilter assets;

  /// u32
  final BigInt maxAssets;

  /// MultiLocation
  final _i5.MultiLocation beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositAsset': {
          'assets': assets.toJson(),
          'maxAssets': maxAssets,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxAssets);
    size = size + _i5.MultiLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxAssets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DepositAsset &&
          other.assets == assets &&
          other.maxAssets == maxAssets &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        assets,
        maxAssets,
        beneficiary,
      );
}

class DepositReserveAsset extends Instruction {
  const DepositReserveAsset({
    required this.assets,
    required this.maxAssets,
    required this.dest,
    required this.xcm,
  });

  factory DepositReserveAsset._decode(_i1.Input input) {
    return DepositReserveAsset(
      assets: _i10.MultiAssetFilter.codec.decode(input),
      maxAssets: _i1.CompactBigIntCodec.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec)
          .decode(input),
    );
  }

  /// MultiAssetFilter
  final _i10.MultiAssetFilter assets;

  /// u32
  final BigInt maxAssets;

  /// MultiLocation
  final _i5.MultiLocation dest;

  /// Xcm<()>
  final _i6.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositReserveAsset': {
          'assets': assets.toJson(),
          'maxAssets': maxAssets,
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxAssets);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + const _i6.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxAssets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DepositReserveAsset &&
          other.assets == assets &&
          other.maxAssets == maxAssets &&
          other.dest == dest &&
          _i13.listsEqual(
            other.xcm,
            xcm,
          );

  @override
  int get hashCode => Object.hash(
        assets,
        maxAssets,
        dest,
        xcm,
      );
}

class ExchangeAsset extends Instruction {
  const ExchangeAsset({
    required this.give,
    required this.receive,
  });

  factory ExchangeAsset._decode(_i1.Input input) {
    return ExchangeAsset(
      give: _i10.MultiAssetFilter.codec.decode(input),
      receive: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
    );
  }

  /// MultiAssetFilter
  final _i10.MultiAssetFilter give;

  /// MultiAssets
  final _i3.MultiAssets receive;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExchangeAsset': {
          'give': give.toJson(),
          'receive': receive.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(give);
    size = size + const _i3.MultiAssetsCodec().sizeHint(receive);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      give,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      receive,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExchangeAsset &&
          other.give == give &&
          _i13.listsEqual(
            other.receive,
            receive,
          );

  @override
  int get hashCode => Object.hash(
        give,
        receive,
      );
}

class InitiateReserveWithdraw extends Instruction {
  const InitiateReserveWithdraw({
    required this.assets,
    required this.reserve,
    required this.xcm,
  });

  factory InitiateReserveWithdraw._decode(_i1.Input input) {
    return InitiateReserveWithdraw(
      assets: _i10.MultiAssetFilter.codec.decode(input),
      reserve: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec)
          .decode(input),
    );
  }

  /// MultiAssetFilter
  final _i10.MultiAssetFilter assets;

  /// MultiLocation
  final _i5.MultiLocation reserve;

  /// Xcm<()>
  final _i6.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InitiateReserveWithdraw': {
          'assets': assets.toJson(),
          'reserve': reserve.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(reserve);
    size = size + const _i6.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      reserve,
      output,
    );
    const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InitiateReserveWithdraw &&
          other.assets == assets &&
          other.reserve == reserve &&
          _i13.listsEqual(
            other.xcm,
            xcm,
          );

  @override
  int get hashCode => Object.hash(
        assets,
        reserve,
        xcm,
      );
}

class InitiateTeleport extends Instruction {
  const InitiateTeleport({
    required this.assets,
    required this.dest,
    required this.xcm,
  });

  factory InitiateTeleport._decode(_i1.Input input) {
    return InitiateTeleport(
      assets: _i10.MultiAssetFilter.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec)
          .decode(input),
    );
  }

  /// MultiAssetFilter
  final _i10.MultiAssetFilter assets;

  /// MultiLocation
  final _i5.MultiLocation dest;

  /// Xcm<()>
  final _i6.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'InitiateTeleport': {
          'assets': assets.toJson(),
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + const _i6.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec).encodeTo(
      xcm,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InitiateTeleport &&
          other.assets == assets &&
          other.dest == dest &&
          _i13.listsEqual(
            other.xcm,
            xcm,
          );

  @override
  int get hashCode => Object.hash(
        assets,
        dest,
        xcm,
      );
}

class QueryHolding extends Instruction {
  const QueryHolding({
    required this.queryId,
    required this.dest,
    required this.assets,
    required this.maxResponseWeight,
  });

  factory QueryHolding._decode(_i1.Input input) {
    return QueryHolding(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      dest: _i5.MultiLocation.codec.decode(input),
      assets: _i10.MultiAssetFilter.codec.decode(input),
      maxResponseWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt queryId;

  /// MultiLocation
  final _i5.MultiLocation dest;

  /// MultiAssetFilter
  final _i10.MultiAssetFilter assets;

  /// u64
  final BigInt maxResponseWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryHolding': {
          'queryId': queryId,
          'dest': dest.toJson(),
          'assets': assets.toJson(),
          'maxResponseWeight': maxResponseWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i5.MultiLocation.codec.sizeHint(dest);
    size = size + _i10.MultiAssetFilter.codec.sizeHint(assets);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxResponseWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i10.MultiAssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxResponseWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueryHolding &&
          other.queryId == queryId &&
          other.dest == dest &&
          other.assets == assets &&
          other.maxResponseWeight == maxResponseWeight;

  @override
  int get hashCode => Object.hash(
        queryId,
        dest,
        assets,
        maxResponseWeight,
      );
}

class BuyExecution extends Instruction {
  const BuyExecution({
    required this.fees,
    required this.weightLimit,
  });

  factory BuyExecution._decode(_i1.Input input) {
    return BuyExecution(
      fees: _i11.MultiAsset.codec.decode(input),
      weightLimit: _i12.WeightLimit.codec.decode(input),
    );
  }

  /// MultiAsset
  final _i11.MultiAsset fees;

  /// WeightLimit
  final _i12.WeightLimit weightLimit;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'BuyExecution': {
          'fees': fees.toJson(),
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i11.MultiAsset.codec.sizeHint(fees);
    size = size + _i12.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i11.MultiAsset.codec.encodeTo(
      fees,
      output,
    );
    _i12.WeightLimit.codec.encodeTo(
      weightLimit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BuyExecution &&
          other.fees == fees &&
          other.weightLimit == weightLimit;

  @override
  int get hashCode => Object.hash(
        fees,
        weightLimit,
      );
}

class RefundSurplus extends Instruction {
  const RefundSurplus();

  @override
  Map<String, dynamic> toJson() => {'RefundSurplus': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RefundSurplus;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SetErrorHandler extends Instruction {
  const SetErrorHandler(this.value0);

  factory SetErrorHandler._decode(_i1.Input input) {
    return SetErrorHandler(
        const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec)
            .decode(input));
  }

  /// Xcm<RuntimeCall>
  final _i6.Xcm value0;

  @override
  Map<String, List<dynamic>> toJson() =>
      {'SetErrorHandler': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.XcmCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetErrorHandler &&
          _i13.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class SetAppendix extends Instruction {
  const SetAppendix(this.value0);

  factory SetAppendix._decode(_i1.Input input) {
    return SetAppendix(
        const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec)
            .decode(input));
  }

  /// Xcm<RuntimeCall>
  final _i6.Xcm value0;

  @override
  Map<String, List<dynamic>> toJson() =>
      {'SetAppendix': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.XcmCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.SequenceCodec<_i14.Instruction>(_i14.Instruction.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetAppendix &&
          _i13.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ClearError extends Instruction {
  const ClearError();

  @override
  Map<String, dynamic> toJson() => {'ClearError': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClearError;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ClaimAsset extends Instruction {
  const ClaimAsset({
    required this.assets,
    required this.ticket,
  });

  factory ClaimAsset._decode(_i1.Input input) {
    return ClaimAsset(
      assets: const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec)
          .decode(input),
      ticket: _i5.MultiLocation.codec.decode(input),
    );
  }

  /// MultiAssets
  final _i3.MultiAssets assets;

  /// MultiLocation
  final _i5.MultiLocation ticket;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ClaimAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'ticket': ticket.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(assets);
    size = size + _i5.MultiLocation.codec.sizeHint(ticket);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    const _i1.SequenceCodec<_i11.MultiAsset>(_i11.MultiAsset.codec).encodeTo(
      assets,
      output,
    );
    _i5.MultiLocation.codec.encodeTo(
      ticket,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimAsset &&
          _i13.listsEqual(
            other.assets,
            assets,
          ) &&
          other.ticket == ticket;

  @override
  int get hashCode => Object.hash(
        assets,
        ticket,
      );
}

class Trap extends Instruction {
  const Trap(this.value0);

  factory Trap._decode(_i1.Input input) {
    return Trap(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u64
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Trap': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Trap && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class SubscribeVersion extends Instruction {
  const SubscribeVersion({
    required this.queryId,
    required this.maxResponseWeight,
  });

  factory SubscribeVersion._decode(_i1.Input input) {
    return SubscribeVersion(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      maxResponseWeight: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt queryId;

  /// u64
  final BigInt maxResponseWeight;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'SubscribeVersion': {
          'queryId': queryId,
          'maxResponseWeight': maxResponseWeight,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxResponseWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      queryId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxResponseWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubscribeVersion &&
          other.queryId == queryId &&
          other.maxResponseWeight == maxResponseWeight;

  @override
  int get hashCode => Object.hash(
        queryId,
        maxResponseWeight,
      );
}

class UnsubscribeVersion extends Instruction {
  const UnsubscribeVersion();

  @override
  Map<String, dynamic> toJson() => {'UnsubscribeVersion': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UnsubscribeVersion;

  @override
  int get hashCode => runtimeType.hashCode;
}
