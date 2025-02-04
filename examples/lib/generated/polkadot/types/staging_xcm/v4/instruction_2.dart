// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i21;

import '../../sp_weights/weight_v2/weight.dart' as _i5;
import '../../tuples.dart' as _i16;
import '../../xcm/double_encoded/double_encoded_2.dart' as _i9;
import '../../xcm/v3/maybe_error_code.dart' as _i18;
import '../../xcm/v3/origin_kind.dart' as _i8;
import '../../xcm/v3/traits/error.dart' as _i17;
import '../../xcm/v3/weight_limit.dart' as _i14;
import 'asset/asset.dart' as _i13;
import 'asset/asset_filter.dart' as _i12;
import 'asset/assets.dart' as _i3;
import 'instruction_1.dart' as _i22;
import 'instruction_2.dart' as _i23;
import 'junction/junction.dart' as _i19;
import 'junction/network_id.dart' as _i20;
import 'junctions/junctions.dart' as _i10;
import 'location/location.dart' as _i6;
import 'query_response_info.dart' as _i11;
import 'response.dart' as _i4;
import 'xcm_1.dart' as _i7;
import 'xcm_2.dart' as _i15;

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

  WithdrawAsset withdrawAsset(_i3.Assets value0) {
    return WithdrawAsset(value0);
  }

  ReserveAssetDeposited reserveAssetDeposited(_i3.Assets value0) {
    return ReserveAssetDeposited(value0);
  }

  ReceiveTeleportedAsset receiveTeleportedAsset(_i3.Assets value0) {
    return ReceiveTeleportedAsset(value0);
  }

  QueryResponse queryResponse({
    required BigInt queryId,
    required _i4.Response response,
    required _i5.Weight maxWeight,
    _i6.Location? querier,
  }) {
    return QueryResponse(
      queryId: queryId,
      response: response,
      maxWeight: maxWeight,
      querier: querier,
    );
  }

  TransferAsset transferAsset({
    required _i3.Assets assets,
    required _i6.Location beneficiary,
  }) {
    return TransferAsset(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  TransferReserveAsset transferReserveAsset({
    required _i3.Assets assets,
    required _i6.Location dest,
    required _i7.Xcm xcm,
  }) {
    return TransferReserveAsset(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  Transact transact({
    required _i8.OriginKind originKind,
    required _i5.Weight requireWeightAtMost,
    required _i9.DoubleEncoded call,
  }) {
    return Transact(
      originKind: originKind,
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

  DescendOrigin descendOrigin(_i10.Junctions value0) {
    return DescendOrigin(value0);
  }

  ReportError reportError(_i11.QueryResponseInfo value0) {
    return ReportError(value0);
  }

  DepositAsset depositAsset({
    required _i12.AssetFilter assets,
    required _i6.Location beneficiary,
  }) {
    return DepositAsset(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  DepositReserveAsset depositReserveAsset({
    required _i12.AssetFilter assets,
    required _i6.Location dest,
    required _i7.Xcm xcm,
  }) {
    return DepositReserveAsset(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  ExchangeAsset exchangeAsset({
    required _i12.AssetFilter give,
    required _i3.Assets want,
    required bool maximal,
  }) {
    return ExchangeAsset(
      give: give,
      want: want,
      maximal: maximal,
    );
  }

  InitiateReserveWithdraw initiateReserveWithdraw({
    required _i12.AssetFilter assets,
    required _i6.Location reserve,
    required _i7.Xcm xcm,
  }) {
    return InitiateReserveWithdraw(
      assets: assets,
      reserve: reserve,
      xcm: xcm,
    );
  }

  InitiateTeleport initiateTeleport({
    required _i12.AssetFilter assets,
    required _i6.Location dest,
    required _i7.Xcm xcm,
  }) {
    return InitiateTeleport(
      assets: assets,
      dest: dest,
      xcm: xcm,
    );
  }

  ReportHolding reportHolding({
    required _i11.QueryResponseInfo responseInfo,
    required _i12.AssetFilter assets,
  }) {
    return ReportHolding(
      responseInfo: responseInfo,
      assets: assets,
    );
  }

  BuyExecution buyExecution({
    required _i13.Asset fees,
    required _i14.WeightLimit weightLimit,
  }) {
    return BuyExecution(
      fees: fees,
      weightLimit: weightLimit,
    );
  }

  RefundSurplus refundSurplus() {
    return RefundSurplus();
  }

  SetErrorHandler setErrorHandler(_i15.Xcm value0) {
    return SetErrorHandler(value0);
  }

  SetAppendix setAppendix(_i15.Xcm value0) {
    return SetAppendix(value0);
  }

  ClearError clearError() {
    return ClearError();
  }

  ClaimAsset claimAsset({
    required _i3.Assets assets,
    required _i6.Location ticket,
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
    required _i5.Weight maxResponseWeight,
  }) {
    return SubscribeVersion(
      queryId: queryId,
      maxResponseWeight: maxResponseWeight,
    );
  }

  UnsubscribeVersion unsubscribeVersion() {
    return UnsubscribeVersion();
  }

  BurnAsset burnAsset(_i3.Assets value0) {
    return BurnAsset(value0);
  }

  ExpectAsset expectAsset(_i3.Assets value0) {
    return ExpectAsset(value0);
  }

  ExpectOrigin expectOrigin(_i6.Location? value0) {
    return ExpectOrigin(value0);
  }

  ExpectError expectError(_i16.Tuple2<int, _i17.Error>? value0) {
    return ExpectError(value0);
  }

  ExpectTransactStatus expectTransactStatus(_i18.MaybeErrorCode value0) {
    return ExpectTransactStatus(value0);
  }

  QueryPallet queryPallet({
    required List<int> moduleName,
    required _i11.QueryResponseInfo responseInfo,
  }) {
    return QueryPallet(
      moduleName: moduleName,
      responseInfo: responseInfo,
    );
  }

  ExpectPallet expectPallet({
    required BigInt index,
    required List<int> name,
    required List<int> moduleName,
    required BigInt crateMajor,
    required BigInt minCrateMinor,
  }) {
    return ExpectPallet(
      index: index,
      name: name,
      moduleName: moduleName,
      crateMajor: crateMajor,
      minCrateMinor: minCrateMinor,
    );
  }

  ReportTransactStatus reportTransactStatus(_i11.QueryResponseInfo value0) {
    return ReportTransactStatus(value0);
  }

  ClearTransactStatus clearTransactStatus() {
    return ClearTransactStatus();
  }

  UniversalOrigin universalOrigin(_i19.Junction value0) {
    return UniversalOrigin(value0);
  }

  ExportMessage exportMessage({
    required _i20.NetworkId network,
    required _i10.Junctions destination,
    required _i7.Xcm xcm,
  }) {
    return ExportMessage(
      network: network,
      destination: destination,
      xcm: xcm,
    );
  }

  LockAsset lockAsset({
    required _i13.Asset asset,
    required _i6.Location unlocker,
  }) {
    return LockAsset(
      asset: asset,
      unlocker: unlocker,
    );
  }

  UnlockAsset unlockAsset({
    required _i13.Asset asset,
    required _i6.Location target,
  }) {
    return UnlockAsset(
      asset: asset,
      target: target,
    );
  }

  NoteUnlockable noteUnlockable({
    required _i13.Asset asset,
    required _i6.Location owner,
  }) {
    return NoteUnlockable(
      asset: asset,
      owner: owner,
    );
  }

  RequestUnlock requestUnlock({
    required _i13.Asset asset,
    required _i6.Location locker,
  }) {
    return RequestUnlock(
      asset: asset,
      locker: locker,
    );
  }

  SetFeesMode setFeesMode({required bool jitWithdraw}) {
    return SetFeesMode(jitWithdraw: jitWithdraw);
  }

  SetTopic setTopic(List<int> value0) {
    return SetTopic(value0);
  }

  ClearTopic clearTopic() {
    return ClearTopic();
  }

  AliasOrigin aliasOrigin(_i6.Location value0) {
    return AliasOrigin(value0);
  }

  UnpaidExecution unpaidExecution({
    required _i14.WeightLimit weightLimit,
    _i6.Location? checkOrigin,
  }) {
    return UnpaidExecution(
      weightLimit: weightLimit,
      checkOrigin: checkOrigin,
    );
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
        return ReportHolding._decode(input);
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
      case 28:
        return BurnAsset._decode(input);
      case 29:
        return ExpectAsset._decode(input);
      case 30:
        return ExpectOrigin._decode(input);
      case 31:
        return ExpectError._decode(input);
      case 32:
        return ExpectTransactStatus._decode(input);
      case 33:
        return QueryPallet._decode(input);
      case 34:
        return ExpectPallet._decode(input);
      case 35:
        return ReportTransactStatus._decode(input);
      case 36:
        return const ClearTransactStatus();
      case 37:
        return UniversalOrigin._decode(input);
      case 38:
        return ExportMessage._decode(input);
      case 39:
        return LockAsset._decode(input);
      case 40:
        return UnlockAsset._decode(input);
      case 41:
        return NoteUnlockable._decode(input);
      case 42:
        return RequestUnlock._decode(input);
      case 43:
        return SetFeesMode._decode(input);
      case 44:
        return SetTopic._decode(input);
      case 45:
        return const ClearTopic();
      case 46:
        return AliasOrigin._decode(input);
      case 47:
        return UnpaidExecution._decode(input);
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
      case ReportHolding:
        (value as ReportHolding).encodeTo(output);
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
      case BurnAsset:
        (value as BurnAsset).encodeTo(output);
        break;
      case ExpectAsset:
        (value as ExpectAsset).encodeTo(output);
        break;
      case ExpectOrigin:
        (value as ExpectOrigin).encodeTo(output);
        break;
      case ExpectError:
        (value as ExpectError).encodeTo(output);
        break;
      case ExpectTransactStatus:
        (value as ExpectTransactStatus).encodeTo(output);
        break;
      case QueryPallet:
        (value as QueryPallet).encodeTo(output);
        break;
      case ExpectPallet:
        (value as ExpectPallet).encodeTo(output);
        break;
      case ReportTransactStatus:
        (value as ReportTransactStatus).encodeTo(output);
        break;
      case ClearTransactStatus:
        (value as ClearTransactStatus).encodeTo(output);
        break;
      case UniversalOrigin:
        (value as UniversalOrigin).encodeTo(output);
        break;
      case ExportMessage:
        (value as ExportMessage).encodeTo(output);
        break;
      case LockAsset:
        (value as LockAsset).encodeTo(output);
        break;
      case UnlockAsset:
        (value as UnlockAsset).encodeTo(output);
        break;
      case NoteUnlockable:
        (value as NoteUnlockable).encodeTo(output);
        break;
      case RequestUnlock:
        (value as RequestUnlock).encodeTo(output);
        break;
      case SetFeesMode:
        (value as SetFeesMode).encodeTo(output);
        break;
      case SetTopic:
        (value as SetTopic).encodeTo(output);
        break;
      case ClearTopic:
        (value as ClearTopic).encodeTo(output);
        break;
      case AliasOrigin:
        (value as AliasOrigin).encodeTo(output);
        break;
      case UnpaidExecution:
        (value as UnpaidExecution).encodeTo(output);
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
      case ReportHolding:
        return (value as ReportHolding)._sizeHint();
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
      case BurnAsset:
        return (value as BurnAsset)._sizeHint();
      case ExpectAsset:
        return (value as ExpectAsset)._sizeHint();
      case ExpectOrigin:
        return (value as ExpectOrigin)._sizeHint();
      case ExpectError:
        return (value as ExpectError)._sizeHint();
      case ExpectTransactStatus:
        return (value as ExpectTransactStatus)._sizeHint();
      case QueryPallet:
        return (value as QueryPallet)._sizeHint();
      case ExpectPallet:
        return (value as ExpectPallet)._sizeHint();
      case ReportTransactStatus:
        return (value as ReportTransactStatus)._sizeHint();
      case ClearTransactStatus:
        return 1;
      case UniversalOrigin:
        return (value as UniversalOrigin)._sizeHint();
      case ExportMessage:
        return (value as ExportMessage)._sizeHint();
      case LockAsset:
        return (value as LockAsset)._sizeHint();
      case UnlockAsset:
        return (value as UnlockAsset)._sizeHint();
      case NoteUnlockable:
        return (value as NoteUnlockable)._sizeHint();
      case RequestUnlock:
        return (value as RequestUnlock)._sizeHint();
      case SetFeesMode:
        return (value as SetFeesMode)._sizeHint();
      case SetTopic:
        return (value as SetTopic)._sizeHint();
      case ClearTopic:
        return 1;
      case AliasOrigin:
        return (value as AliasOrigin)._sizeHint();
      case UnpaidExecution:
        return (value as UnpaidExecution)._sizeHint();
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
        const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input));
  }

  /// Assets
  final _i3.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'WithdrawAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
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
          _i21.listsEqual(
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
        const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input));
  }

  /// Assets
  final _i3.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'ReserveAssetDeposited': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
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
          _i21.listsEqual(
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
        const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input));
  }

  /// Assets
  final _i3.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() => {
        'ReceiveTeleportedAsset': value0.map((value) => value.toJson()).toList()
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
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
          _i21.listsEqual(
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
    this.querier,
  });

  factory QueryResponse._decode(_i1.Input input) {
    return QueryResponse(
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      response: _i4.Response.codec.decode(input),
      maxWeight: _i5.Weight.codec.decode(input),
      querier:
          const _i1.OptionCodec<_i6.Location>(_i6.Location.codec).decode(input),
    );
  }

  /// QueryId
  final BigInt queryId;

  /// Response
  final _i4.Response response;

  /// Weight
  final _i5.Weight maxWeight;

  /// Option<Location>
  final _i6.Location? querier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryResponse': {
          'queryId': queryId,
          'response': response.toJson(),
          'maxWeight': maxWeight.toJson(),
          'querier': querier?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i4.Response.codec.sizeHint(response);
    size = size + _i5.Weight.codec.sizeHint(maxWeight);
    size = size +
        const _i1.OptionCodec<_i6.Location>(_i6.Location.codec)
            .sizeHint(querier);
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
    _i5.Weight.codec.encodeTo(
      maxWeight,
      output,
    );
    const _i1.OptionCodec<_i6.Location>(_i6.Location.codec).encodeTo(
      querier,
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
          other.maxWeight == maxWeight &&
          other.querier == querier;

  @override
  int get hashCode => Object.hash(
        queryId,
        response,
        maxWeight,
        querier,
      );
}

class TransferAsset extends Instruction {
  const TransferAsset({
    required this.assets,
    required this.beneficiary,
  });

  factory TransferAsset._decode(_i1.Input input) {
    return TransferAsset(
      assets:
          const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input),
      beneficiary: _i6.Location.codec.decode(input),
    );
  }

  /// Assets
  final _i3.Assets assets;

  /// Location
  final _i6.Location beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TransferAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
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
          _i21.listsEqual(
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
      assets:
          const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input),
      dest: _i6.Location.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec)
          .decode(input),
    );
  }

  /// Assets
  final _i3.Assets assets;

  /// Location
  final _i6.Location dest;

  /// Xcm<()>
  final _i7.Xcm xcm;

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
    size = size + const _i3.AssetsCodec().sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(dest);
    size = size + const _i7.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec).encodeTo(
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
          _i21.listsEqual(
            other.assets,
            assets,
          ) &&
          other.dest == dest &&
          _i21.listsEqual(
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
    required this.originKind,
    required this.requireWeightAtMost,
    required this.call,
  });

  factory Transact._decode(_i1.Input input) {
    return Transact(
      originKind: _i8.OriginKind.codec.decode(input),
      requireWeightAtMost: _i5.Weight.codec.decode(input),
      call: _i9.DoubleEncoded.codec.decode(input),
    );
  }

  /// OriginKind
  final _i8.OriginKind originKind;

  /// Weight
  final _i5.Weight requireWeightAtMost;

  /// DoubleEncoded<Call>
  final _i9.DoubleEncoded call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Transact': {
          'originKind': originKind.toJson(),
          'requireWeightAtMost': requireWeightAtMost.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.OriginKind.codec.sizeHint(originKind);
    size = size + _i5.Weight.codec.sizeHint(requireWeightAtMost);
    size = size + _i9.DoubleEncoded.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i8.OriginKind.codec.encodeTo(
      originKind,
      output,
    );
    _i5.Weight.codec.encodeTo(
      requireWeightAtMost,
      output,
    );
    _i9.DoubleEncoded.codec.encodeTo(
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
          other.originKind == originKind &&
          other.requireWeightAtMost == requireWeightAtMost &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        originKind,
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
    return DescendOrigin(_i10.Junctions.codec.decode(input));
  }

  /// InteriorLocation
  final _i10.Junctions value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'DescendOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Junctions.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i10.Junctions.codec.encodeTo(
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
  const ReportError(this.value0);

  factory ReportError._decode(_i1.Input input) {
    return ReportError(_i11.QueryResponseInfo.codec.decode(input));
  }

  /// QueryResponseInfo
  final _i11.QueryResponseInfo value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ReportError': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.QueryResponseInfo.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
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
      other is ReportError && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class DepositAsset extends Instruction {
  const DepositAsset({
    required this.assets,
    required this.beneficiary,
  });

  factory DepositAsset._decode(_i1.Input input) {
    return DepositAsset(
      assets: _i12.AssetFilter.codec.decode(input),
      beneficiary: _i6.Location.codec.decode(input),
    );
  }

  /// AssetFilter
  final _i12.AssetFilter assets;

  /// Location
  final _i6.Location beneficiary;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'DepositAsset': {
          'assets': assets.toJson(),
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.AssetFilter.codec.sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i12.AssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
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
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        assets,
        beneficiary,
      );
}

class DepositReserveAsset extends Instruction {
  const DepositReserveAsset({
    required this.assets,
    required this.dest,
    required this.xcm,
  });

  factory DepositReserveAsset._decode(_i1.Input input) {
    return DepositReserveAsset(
      assets: _i12.AssetFilter.codec.decode(input),
      dest: _i6.Location.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec)
          .decode(input),
    );
  }

  /// AssetFilter
  final _i12.AssetFilter assets;

  /// Location
  final _i6.Location dest;

  /// Xcm<()>
  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositReserveAsset': {
          'assets': assets.toJson(),
          'dest': dest.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.AssetFilter.codec.sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(dest);
    size = size + const _i7.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i12.AssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec).encodeTo(
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
          other.dest == dest &&
          _i21.listsEqual(
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

class ExchangeAsset extends Instruction {
  const ExchangeAsset({
    required this.give,
    required this.want,
    required this.maximal,
  });

  factory ExchangeAsset._decode(_i1.Input input) {
    return ExchangeAsset(
      give: _i12.AssetFilter.codec.decode(input),
      want: const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input),
      maximal: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// AssetFilter
  final _i12.AssetFilter give;

  /// Assets
  final _i3.Assets want;

  /// bool
  final bool maximal;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExchangeAsset': {
          'give': give.toJson(),
          'want': want.map((value) => value.toJson()).toList(),
          'maximal': maximal,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.AssetFilter.codec.sizeHint(give);
    size = size + const _i3.AssetsCodec().sizeHint(want);
    size = size + _i1.BoolCodec.codec.sizeHint(maximal);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i12.AssetFilter.codec.encodeTo(
      give,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
      want,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      maximal,
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
          _i21.listsEqual(
            other.want,
            want,
          ) &&
          other.maximal == maximal;

  @override
  int get hashCode => Object.hash(
        give,
        want,
        maximal,
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
      assets: _i12.AssetFilter.codec.decode(input),
      reserve: _i6.Location.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec)
          .decode(input),
    );
  }

  /// AssetFilter
  final _i12.AssetFilter assets;

  /// Location
  final _i6.Location reserve;

  /// Xcm<()>
  final _i7.Xcm xcm;

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
    size = size + _i12.AssetFilter.codec.sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(reserve);
    size = size + const _i7.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i12.AssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
      reserve,
      output,
    );
    const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec).encodeTo(
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
          _i21.listsEqual(
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
      assets: _i12.AssetFilter.codec.decode(input),
      dest: _i6.Location.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec)
          .decode(input),
    );
  }

  /// AssetFilter
  final _i12.AssetFilter assets;

  /// Location
  final _i6.Location dest;

  /// Xcm<()>
  final _i7.Xcm xcm;

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
    size = size + _i12.AssetFilter.codec.sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(dest);
    size = size + const _i7.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i12.AssetFilter.codec.encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
      dest,
      output,
    );
    const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec).encodeTo(
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
          _i21.listsEqual(
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

class ReportHolding extends Instruction {
  const ReportHolding({
    required this.responseInfo,
    required this.assets,
  });

  factory ReportHolding._decode(_i1.Input input) {
    return ReportHolding(
      responseInfo: _i11.QueryResponseInfo.codec.decode(input),
      assets: _i12.AssetFilter.codec.decode(input),
    );
  }

  /// QueryResponseInfo
  final _i11.QueryResponseInfo responseInfo;

  /// AssetFilter
  final _i12.AssetFilter assets;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'ReportHolding': {
          'responseInfo': responseInfo.toJson(),
          'assets': assets.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i11.QueryResponseInfo.codec.sizeHint(responseInfo);
    size = size + _i12.AssetFilter.codec.sizeHint(assets);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
      responseInfo,
      output,
    );
    _i12.AssetFilter.codec.encodeTo(
      assets,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportHolding &&
          other.responseInfo == responseInfo &&
          other.assets == assets;

  @override
  int get hashCode => Object.hash(
        responseInfo,
        assets,
      );
}

class BuyExecution extends Instruction {
  const BuyExecution({
    required this.fees,
    required this.weightLimit,
  });

  factory BuyExecution._decode(_i1.Input input) {
    return BuyExecution(
      fees: _i13.Asset.codec.decode(input),
      weightLimit: _i14.WeightLimit.codec.decode(input),
    );
  }

  /// Asset
  final _i13.Asset fees;

  /// WeightLimit
  final _i14.WeightLimit weightLimit;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'BuyExecution': {
          'fees': fees.toJson(),
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Asset.codec.sizeHint(fees);
    size = size + _i14.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i13.Asset.codec.encodeTo(
      fees,
      output,
    );
    _i14.WeightLimit.codec.encodeTo(
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
        const _i1.SequenceCodec<_i23.Instruction>(_i23.Instruction.codec)
            .decode(input));
  }

  /// Xcm<Call>
  final _i15.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'SetErrorHandler': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i15.XcmCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    const _i1.SequenceCodec<_i23.Instruction>(_i23.Instruction.codec).encodeTo(
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
          _i21.listsEqual(
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
        const _i1.SequenceCodec<_i23.Instruction>(_i23.Instruction.codec)
            .decode(input));
  }

  /// Xcm<Call>
  final _i15.Xcm value0;

  @override
  Map<String, List<dynamic>> toJson() =>
      {'SetAppendix': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i15.XcmCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.SequenceCodec<_i23.Instruction>(_i23.Instruction.codec).encodeTo(
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
          _i21.listsEqual(
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
      assets:
          const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input),
      ticket: _i6.Location.codec.decode(input),
    );
  }

  /// Assets
  final _i3.Assets assets;

  /// Location
  final _i6.Location ticket;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ClaimAsset': {
          'assets': assets.map((value) => value.toJson()).toList(),
          'ticket': ticket.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(assets);
    size = size + _i6.Location.codec.sizeHint(ticket);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
      assets,
      output,
    );
    _i6.Location.codec.encodeTo(
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
          _i21.listsEqual(
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
      maxResponseWeight: _i5.Weight.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt queryId;

  /// Weight
  final _i5.Weight maxResponseWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SubscribeVersion': {
          'queryId': queryId,
          'maxResponseWeight': maxResponseWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(queryId);
    size = size + _i5.Weight.codec.sizeHint(maxResponseWeight);
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
    _i5.Weight.codec.encodeTo(
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

class BurnAsset extends Instruction {
  const BurnAsset(this.value0);

  factory BurnAsset._decode(_i1.Input input) {
    return BurnAsset(
        const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input));
  }

  /// Assets
  final _i3.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'BurnAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
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
      other is BurnAsset &&
          _i21.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ExpectAsset extends Instruction {
  const ExpectAsset(this.value0);

  factory ExpectAsset._decode(_i1.Input input) {
    return ExpectAsset(
        const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).decode(input));
  }

  /// Assets
  final _i3.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'ExpectAsset': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    const _i1.SequenceCodec<_i13.Asset>(_i13.Asset.codec).encodeTo(
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
      other is ExpectAsset &&
          _i21.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ExpectOrigin extends Instruction {
  const ExpectOrigin(this.value0);

  factory ExpectOrigin._decode(_i1.Input input) {
    return ExpectOrigin(
        const _i1.OptionCodec<_i6.Location>(_i6.Location.codec).decode(input));
  }

  /// Option<Location>
  final _i6.Location? value0;

  @override
  Map<String, Map<String, dynamic>?> toJson() =>
      {'ExpectOrigin': value0?.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i6.Location>(_i6.Location.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    const _i1.OptionCodec<_i6.Location>(_i6.Location.codec).encodeTo(
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
      other is ExpectOrigin && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ExpectError extends Instruction {
  const ExpectError(this.value0);

  factory ExpectError._decode(_i1.Input input) {
    return ExpectError(const _i1.OptionCodec<_i16.Tuple2<int, _i17.Error>>(
        _i16.Tuple2Codec<int, _i17.Error>(
      _i1.U32Codec.codec,
      _i17.Error.codec,
    )).decode(input));
  }

  /// Option<(u32, Error)>
  final _i16.Tuple2<int, _i17.Error>? value0;

  @override
  Map<String, List<dynamic>?> toJson() => {
        'ExpectError': [
          value0?.value0,
          value0?.value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i16.Tuple2<int, _i17.Error>>(
            _i16.Tuple2Codec<int, _i17.Error>(
          _i1.U32Codec.codec,
          _i17.Error.codec,
        )).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    const _i1.OptionCodec<_i16.Tuple2<int, _i17.Error>>(
        _i16.Tuple2Codec<int, _i17.Error>(
      _i1.U32Codec.codec,
      _i17.Error.codec,
    )).encodeTo(
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
      other is ExpectError && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ExpectTransactStatus extends Instruction {
  const ExpectTransactStatus(this.value0);

  factory ExpectTransactStatus._decode(_i1.Input input) {
    return ExpectTransactStatus(_i18.MaybeErrorCode.codec.decode(input));
  }

  /// MaybeErrorCode
  final _i18.MaybeErrorCode value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ExpectTransactStatus': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.MaybeErrorCode.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i18.MaybeErrorCode.codec.encodeTo(
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
      other is ExpectTransactStatus && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class QueryPallet extends Instruction {
  const QueryPallet({
    required this.moduleName,
    required this.responseInfo,
  });

  factory QueryPallet._decode(_i1.Input input) {
    return QueryPallet(
      moduleName: _i1.U8SequenceCodec.codec.decode(input),
      responseInfo: _i11.QueryResponseInfo.codec.decode(input),
    );
  }

  /// Vec<u8>
  final List<int> moduleName;

  /// QueryResponseInfo
  final _i11.QueryResponseInfo responseInfo;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'QueryPallet': {
          'moduleName': moduleName,
          'responseInfo': responseInfo.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(moduleName);
    size = size + _i11.QueryResponseInfo.codec.sizeHint(responseInfo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      moduleName,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
      responseInfo,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueryPallet &&
          _i21.listsEqual(
            other.moduleName,
            moduleName,
          ) &&
          other.responseInfo == responseInfo;

  @override
  int get hashCode => Object.hash(
        moduleName,
        responseInfo,
      );
}

class ExpectPallet extends Instruction {
  const ExpectPallet({
    required this.index,
    required this.name,
    required this.moduleName,
    required this.crateMajor,
    required this.minCrateMinor,
  });

  factory ExpectPallet._decode(_i1.Input input) {
    return ExpectPallet(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      name: _i1.U8SequenceCodec.codec.decode(input),
      moduleName: _i1.U8SequenceCodec.codec.decode(input),
      crateMajor: _i1.CompactBigIntCodec.codec.decode(input),
      minCrateMinor: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// u32
  final BigInt index;

  /// Vec<u8>
  final List<int> name;

  /// Vec<u8>
  final List<int> moduleName;

  /// u32
  final BigInt crateMajor;

  /// u32
  final BigInt minCrateMinor;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExpectPallet': {
          'index': index,
          'name': name,
          'moduleName': moduleName,
          'crateMajor': crateMajor,
          'minCrateMinor': minCrateMinor,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(name);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(moduleName);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(crateMajor);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(minCrateMinor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      name,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      moduleName,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      crateMajor,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      minCrateMinor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExpectPallet &&
          other.index == index &&
          _i21.listsEqual(
            other.name,
            name,
          ) &&
          _i21.listsEqual(
            other.moduleName,
            moduleName,
          ) &&
          other.crateMajor == crateMajor &&
          other.minCrateMinor == minCrateMinor;

  @override
  int get hashCode => Object.hash(
        index,
        name,
        moduleName,
        crateMajor,
        minCrateMinor,
      );
}

class ReportTransactStatus extends Instruction {
  const ReportTransactStatus(this.value0);

  factory ReportTransactStatus._decode(_i1.Input input) {
    return ReportTransactStatus(_i11.QueryResponseInfo.codec.decode(input));
  }

  /// QueryResponseInfo
  final _i11.QueryResponseInfo value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ReportTransactStatus': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.QueryResponseInfo.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i11.QueryResponseInfo.codec.encodeTo(
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
      other is ReportTransactStatus && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ClearTransactStatus extends Instruction {
  const ClearTransactStatus();

  @override
  Map<String, dynamic> toJson() => {'ClearTransactStatus': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClearTransactStatus;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UniversalOrigin extends Instruction {
  const UniversalOrigin(this.value0);

  factory UniversalOrigin._decode(_i1.Input input) {
    return UniversalOrigin(_i19.Junction.codec.decode(input));
  }

  /// Junction
  final _i19.Junction value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'UniversalOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Junction.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
    _i19.Junction.codec.encodeTo(
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
      other is UniversalOrigin && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ExportMessage extends Instruction {
  const ExportMessage({
    required this.network,
    required this.destination,
    required this.xcm,
  });

  factory ExportMessage._decode(_i1.Input input) {
    return ExportMessage(
      network: _i20.NetworkId.codec.decode(input),
      destination: _i10.Junctions.codec.decode(input),
      xcm: const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec)
          .decode(input),
    );
  }

  /// NetworkId
  final _i20.NetworkId network;

  /// InteriorLocation
  final _i10.Junctions destination;

  /// Xcm<()>
  final _i7.Xcm xcm;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ExportMessage': {
          'network': network.toJson(),
          'destination': destination.toJson(),
          'xcm': xcm.map((value) => value.toJson()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i20.NetworkId.codec.sizeHint(network);
    size = size + _i10.Junctions.codec.sizeHint(destination);
    size = size + const _i7.XcmCodec().sizeHint(xcm);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      38,
      output,
    );
    _i20.NetworkId.codec.encodeTo(
      network,
      output,
    );
    _i10.Junctions.codec.encodeTo(
      destination,
      output,
    );
    const _i1.SequenceCodec<_i22.Instruction>(_i22.Instruction.codec).encodeTo(
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
      other is ExportMessage &&
          other.network == network &&
          other.destination == destination &&
          _i21.listsEqual(
            other.xcm,
            xcm,
          );

  @override
  int get hashCode => Object.hash(
        network,
        destination,
        xcm,
      );
}

class LockAsset extends Instruction {
  const LockAsset({
    required this.asset,
    required this.unlocker,
  });

  factory LockAsset._decode(_i1.Input input) {
    return LockAsset(
      asset: _i13.Asset.codec.decode(input),
      unlocker: _i6.Location.codec.decode(input),
    );
  }

  /// Asset
  final _i13.Asset asset;

  /// Location
  final _i6.Location unlocker;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'LockAsset': {
          'asset': asset.toJson(),
          'unlocker': unlocker.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Asset.codec.sizeHint(asset);
    size = size + _i6.Location.codec.sizeHint(unlocker);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      39,
      output,
    );
    _i13.Asset.codec.encodeTo(
      asset,
      output,
    );
    _i6.Location.codec.encodeTo(
      unlocker,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LockAsset && other.asset == asset && other.unlocker == unlocker;

  @override
  int get hashCode => Object.hash(
        asset,
        unlocker,
      );
}

class UnlockAsset extends Instruction {
  const UnlockAsset({
    required this.asset,
    required this.target,
  });

  factory UnlockAsset._decode(_i1.Input input) {
    return UnlockAsset(
      asset: _i13.Asset.codec.decode(input),
      target: _i6.Location.codec.decode(input),
    );
  }

  /// Asset
  final _i13.Asset asset;

  /// Location
  final _i6.Location target;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'UnlockAsset': {
          'asset': asset.toJson(),
          'target': target.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Asset.codec.sizeHint(asset);
    size = size + _i6.Location.codec.sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i13.Asset.codec.encodeTo(
      asset,
      output,
    );
    _i6.Location.codec.encodeTo(
      target,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnlockAsset && other.asset == asset && other.target == target;

  @override
  int get hashCode => Object.hash(
        asset,
        target,
      );
}

class NoteUnlockable extends Instruction {
  const NoteUnlockable({
    required this.asset,
    required this.owner,
  });

  factory NoteUnlockable._decode(_i1.Input input) {
    return NoteUnlockable(
      asset: _i13.Asset.codec.decode(input),
      owner: _i6.Location.codec.decode(input),
    );
  }

  /// Asset
  final _i13.Asset asset;

  /// Location
  final _i6.Location owner;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'NoteUnlockable': {
          'asset': asset.toJson(),
          'owner': owner.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Asset.codec.sizeHint(asset);
    size = size + _i6.Location.codec.sizeHint(owner);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      41,
      output,
    );
    _i13.Asset.codec.encodeTo(
      asset,
      output,
    );
    _i6.Location.codec.encodeTo(
      owner,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NoteUnlockable && other.asset == asset && other.owner == owner;

  @override
  int get hashCode => Object.hash(
        asset,
        owner,
      );
}

class RequestUnlock extends Instruction {
  const RequestUnlock({
    required this.asset,
    required this.locker,
  });

  factory RequestUnlock._decode(_i1.Input input) {
    return RequestUnlock(
      asset: _i13.Asset.codec.decode(input),
      locker: _i6.Location.codec.decode(input),
    );
  }

  /// Asset
  final _i13.Asset asset;

  /// Location
  final _i6.Location locker;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'RequestUnlock': {
          'asset': asset.toJson(),
          'locker': locker.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Asset.codec.sizeHint(asset);
    size = size + _i6.Location.codec.sizeHint(locker);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      42,
      output,
    );
    _i13.Asset.codec.encodeTo(
      asset,
      output,
    );
    _i6.Location.codec.encodeTo(
      locker,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RequestUnlock && other.asset == asset && other.locker == locker;

  @override
  int get hashCode => Object.hash(
        asset,
        locker,
      );
}

class SetFeesMode extends Instruction {
  const SetFeesMode({required this.jitWithdraw});

  factory SetFeesMode._decode(_i1.Input input) {
    return SetFeesMode(jitWithdraw: _i1.BoolCodec.codec.decode(input));
  }

  /// bool
  final bool jitWithdraw;

  @override
  Map<String, Map<String, bool>> toJson() => {
        'SetFeesMode': {'jitWithdraw': jitWithdraw}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(jitWithdraw);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      43,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      jitWithdraw,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetFeesMode && other.jitWithdraw == jitWithdraw;

  @override
  int get hashCode => jitWithdraw.hashCode;
}

class SetTopic extends Instruction {
  const SetTopic(this.value0);

  factory SetTopic._decode(_i1.Input input) {
    return SetTopic(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// [u8; 32]
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'SetTopic': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is SetTopic &&
          _i21.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ClearTopic extends Instruction {
  const ClearTopic();

  @override
  Map<String, dynamic> toJson() => {'ClearTopic': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      45,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClearTopic;

  @override
  int get hashCode => runtimeType.hashCode;
}

class AliasOrigin extends Instruction {
  const AliasOrigin(this.value0);

  factory AliasOrigin._decode(_i1.Input input) {
    return AliasOrigin(_i6.Location.codec.decode(input));
  }

  /// Location
  final _i6.Location value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'AliasOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Location.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      46,
      output,
    );
    _i6.Location.codec.encodeTo(
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
      other is AliasOrigin && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class UnpaidExecution extends Instruction {
  const UnpaidExecution({
    required this.weightLimit,
    this.checkOrigin,
  });

  factory UnpaidExecution._decode(_i1.Input input) {
    return UnpaidExecution(
      weightLimit: _i14.WeightLimit.codec.decode(input),
      checkOrigin:
          const _i1.OptionCodec<_i6.Location>(_i6.Location.codec).decode(input),
    );
  }

  /// WeightLimit
  final _i14.WeightLimit weightLimit;

  /// Option<Location>
  final _i6.Location? checkOrigin;

  @override
  Map<String, Map<String, Map<String, dynamic>?>> toJson() => {
        'UnpaidExecution': {
          'weightLimit': weightLimit.toJson(),
          'checkOrigin': checkOrigin?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i14.WeightLimit.codec.sizeHint(weightLimit);
    size = size +
        const _i1.OptionCodec<_i6.Location>(_i6.Location.codec)
            .sizeHint(checkOrigin);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      47,
      output,
    );
    _i14.WeightLimit.codec.encodeTo(
      weightLimit,
      output,
    );
    const _i1.OptionCodec<_i6.Location>(_i6.Location.codec).encodeTo(
      checkOrigin,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnpaidExecution &&
          other.weightLimit == weightLimit &&
          other.checkOrigin == checkOrigin;

  @override
  int get hashCode => Object.hash(
        weightLimit,
        checkOrigin,
      );
}
