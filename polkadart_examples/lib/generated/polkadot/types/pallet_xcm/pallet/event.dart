// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i14;

import '../../primitive_types/h256.dart' as _i8;
import '../../sp_weights/weight_v2/weight.dart' as _i7;
import '../../xcm/v3/instruction_1.dart' as _i13;
import '../../xcm/v3/multiasset/multi_asset.dart' as _i15;
import '../../xcm/v3/multiasset/multi_assets.dart' as _i10;
import '../../xcm/v3/multilocation/multi_location.dart' as _i4;
import '../../xcm/v3/response.dart' as _i6;
import '../../xcm/v3/traits/error.dart' as _i11;
import '../../xcm/v3/traits/outcome.dart' as _i3;
import '../../xcm/v3/xcm_1.dart' as _i5;
import '../../xcm/versioned_multi_assets.dart' as _i9;
import '../../xcm/versioned_multi_location.dart' as _i12;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  Attempted attempted(_i3.Outcome value0) {
    return Attempted(value0);
  }

  Sent sent(
    _i4.MultiLocation value0,
    _i4.MultiLocation value1,
    _i5.Xcm value2,
  ) {
    return Sent(
      value0,
      value1,
      value2,
    );
  }

  UnexpectedResponse unexpectedResponse(
    _i4.MultiLocation value0,
    BigInt value1,
  ) {
    return UnexpectedResponse(
      value0,
      value1,
    );
  }

  ResponseReady responseReady(
    BigInt value0,
    _i6.Response value1,
  ) {
    return ResponseReady(
      value0,
      value1,
    );
  }

  Notified notified(
    BigInt value0,
    int value1,
    int value2,
  ) {
    return Notified(
      value0,
      value1,
      value2,
    );
  }

  NotifyOverweight notifyOverweight(
    BigInt value0,
    int value1,
    int value2,
    _i7.Weight value3,
    _i7.Weight value4,
  ) {
    return NotifyOverweight(
      value0,
      value1,
      value2,
      value3,
      value4,
    );
  }

  NotifyDispatchError notifyDispatchError(
    BigInt value0,
    int value1,
    int value2,
  ) {
    return NotifyDispatchError(
      value0,
      value1,
      value2,
    );
  }

  NotifyDecodeFailed notifyDecodeFailed(
    BigInt value0,
    int value1,
    int value2,
  ) {
    return NotifyDecodeFailed(
      value0,
      value1,
      value2,
    );
  }

  InvalidResponder invalidResponder(
    _i4.MultiLocation value0,
    BigInt value1,
    _i4.MultiLocation? value2,
  ) {
    return InvalidResponder(
      value0,
      value1,
      value2,
    );
  }

  InvalidResponderVersion invalidResponderVersion(
    _i4.MultiLocation value0,
    BigInt value1,
  ) {
    return InvalidResponderVersion(
      value0,
      value1,
    );
  }

  ResponseTaken responseTaken(BigInt value0) {
    return ResponseTaken(value0);
  }

  AssetsTrapped assetsTrapped(
    _i8.H256 value0,
    _i4.MultiLocation value1,
    _i9.VersionedMultiAssets value2,
  ) {
    return AssetsTrapped(
      value0,
      value1,
      value2,
    );
  }

  VersionChangeNotified versionChangeNotified(
    _i4.MultiLocation value0,
    int value1,
    _i10.MultiAssets value2,
  ) {
    return VersionChangeNotified(
      value0,
      value1,
      value2,
    );
  }

  SupportedVersionChanged supportedVersionChanged(
    _i4.MultiLocation value0,
    int value1,
  ) {
    return SupportedVersionChanged(
      value0,
      value1,
    );
  }

  NotifyTargetSendFail notifyTargetSendFail(
    _i4.MultiLocation value0,
    BigInt value1,
    _i11.Error value2,
  ) {
    return NotifyTargetSendFail(
      value0,
      value1,
      value2,
    );
  }

  NotifyTargetMigrationFail notifyTargetMigrationFail(
    _i12.VersionedMultiLocation value0,
    BigInt value1,
  ) {
    return NotifyTargetMigrationFail(
      value0,
      value1,
    );
  }

  InvalidQuerierVersion invalidQuerierVersion(
    _i4.MultiLocation value0,
    BigInt value1,
  ) {
    return InvalidQuerierVersion(
      value0,
      value1,
    );
  }

  InvalidQuerier invalidQuerier(
    _i4.MultiLocation value0,
    BigInt value1,
    _i4.MultiLocation value2,
    _i4.MultiLocation? value3,
  ) {
    return InvalidQuerier(
      value0,
      value1,
      value2,
      value3,
    );
  }

  VersionNotifyStarted versionNotifyStarted(
    _i4.MultiLocation value0,
    _i10.MultiAssets value1,
  ) {
    return VersionNotifyStarted(
      value0,
      value1,
    );
  }

  VersionNotifyRequested versionNotifyRequested(
    _i4.MultiLocation value0,
    _i10.MultiAssets value1,
  ) {
    return VersionNotifyRequested(
      value0,
      value1,
    );
  }

  VersionNotifyUnrequested versionNotifyUnrequested(
    _i4.MultiLocation value0,
    _i10.MultiAssets value1,
  ) {
    return VersionNotifyUnrequested(
      value0,
      value1,
    );
  }

  FeesPaid feesPaid(
    _i4.MultiLocation value0,
    _i10.MultiAssets value1,
  ) {
    return FeesPaid(
      value0,
      value1,
    );
  }

  AssetsClaimed assetsClaimed(
    _i8.H256 value0,
    _i4.MultiLocation value1,
    _i9.VersionedMultiAssets value2,
  ) {
    return AssetsClaimed(
      value0,
      value1,
      value2,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Attempted._decode(input);
      case 1:
        return Sent._decode(input);
      case 2:
        return UnexpectedResponse._decode(input);
      case 3:
        return ResponseReady._decode(input);
      case 4:
        return Notified._decode(input);
      case 5:
        return NotifyOverweight._decode(input);
      case 6:
        return NotifyDispatchError._decode(input);
      case 7:
        return NotifyDecodeFailed._decode(input);
      case 8:
        return InvalidResponder._decode(input);
      case 9:
        return InvalidResponderVersion._decode(input);
      case 10:
        return ResponseTaken._decode(input);
      case 11:
        return AssetsTrapped._decode(input);
      case 12:
        return VersionChangeNotified._decode(input);
      case 13:
        return SupportedVersionChanged._decode(input);
      case 14:
        return NotifyTargetSendFail._decode(input);
      case 15:
        return NotifyTargetMigrationFail._decode(input);
      case 16:
        return InvalidQuerierVersion._decode(input);
      case 17:
        return InvalidQuerier._decode(input);
      case 18:
        return VersionNotifyStarted._decode(input);
      case 19:
        return VersionNotifyRequested._decode(input);
      case 20:
        return VersionNotifyUnrequested._decode(input);
      case 21:
        return FeesPaid._decode(input);
      case 22:
        return AssetsClaimed._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Attempted:
        (value as Attempted).encodeTo(output);
        break;
      case Sent:
        (value as Sent).encodeTo(output);
        break;
      case UnexpectedResponse:
        (value as UnexpectedResponse).encodeTo(output);
        break;
      case ResponseReady:
        (value as ResponseReady).encodeTo(output);
        break;
      case Notified:
        (value as Notified).encodeTo(output);
        break;
      case NotifyOverweight:
        (value as NotifyOverweight).encodeTo(output);
        break;
      case NotifyDispatchError:
        (value as NotifyDispatchError).encodeTo(output);
        break;
      case NotifyDecodeFailed:
        (value as NotifyDecodeFailed).encodeTo(output);
        break;
      case InvalidResponder:
        (value as InvalidResponder).encodeTo(output);
        break;
      case InvalidResponderVersion:
        (value as InvalidResponderVersion).encodeTo(output);
        break;
      case ResponseTaken:
        (value as ResponseTaken).encodeTo(output);
        break;
      case AssetsTrapped:
        (value as AssetsTrapped).encodeTo(output);
        break;
      case VersionChangeNotified:
        (value as VersionChangeNotified).encodeTo(output);
        break;
      case SupportedVersionChanged:
        (value as SupportedVersionChanged).encodeTo(output);
        break;
      case NotifyTargetSendFail:
        (value as NotifyTargetSendFail).encodeTo(output);
        break;
      case NotifyTargetMigrationFail:
        (value as NotifyTargetMigrationFail).encodeTo(output);
        break;
      case InvalidQuerierVersion:
        (value as InvalidQuerierVersion).encodeTo(output);
        break;
      case InvalidQuerier:
        (value as InvalidQuerier).encodeTo(output);
        break;
      case VersionNotifyStarted:
        (value as VersionNotifyStarted).encodeTo(output);
        break;
      case VersionNotifyRequested:
        (value as VersionNotifyRequested).encodeTo(output);
        break;
      case VersionNotifyUnrequested:
        (value as VersionNotifyUnrequested).encodeTo(output);
        break;
      case FeesPaid:
        (value as FeesPaid).encodeTo(output);
        break;
      case AssetsClaimed:
        (value as AssetsClaimed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Attempted:
        return (value as Attempted)._sizeHint();
      case Sent:
        return (value as Sent)._sizeHint();
      case UnexpectedResponse:
        return (value as UnexpectedResponse)._sizeHint();
      case ResponseReady:
        return (value as ResponseReady)._sizeHint();
      case Notified:
        return (value as Notified)._sizeHint();
      case NotifyOverweight:
        return (value as NotifyOverweight)._sizeHint();
      case NotifyDispatchError:
        return (value as NotifyDispatchError)._sizeHint();
      case NotifyDecodeFailed:
        return (value as NotifyDecodeFailed)._sizeHint();
      case InvalidResponder:
        return (value as InvalidResponder)._sizeHint();
      case InvalidResponderVersion:
        return (value as InvalidResponderVersion)._sizeHint();
      case ResponseTaken:
        return (value as ResponseTaken)._sizeHint();
      case AssetsTrapped:
        return (value as AssetsTrapped)._sizeHint();
      case VersionChangeNotified:
        return (value as VersionChangeNotified)._sizeHint();
      case SupportedVersionChanged:
        return (value as SupportedVersionChanged)._sizeHint();
      case NotifyTargetSendFail:
        return (value as NotifyTargetSendFail)._sizeHint();
      case NotifyTargetMigrationFail:
        return (value as NotifyTargetMigrationFail)._sizeHint();
      case InvalidQuerierVersion:
        return (value as InvalidQuerierVersion)._sizeHint();
      case InvalidQuerier:
        return (value as InvalidQuerier)._sizeHint();
      case VersionNotifyStarted:
        return (value as VersionNotifyStarted)._sizeHint();
      case VersionNotifyRequested:
        return (value as VersionNotifyRequested)._sizeHint();
      case VersionNotifyUnrequested:
        return (value as VersionNotifyUnrequested)._sizeHint();
      case FeesPaid:
        return (value as FeesPaid)._sizeHint();
      case AssetsClaimed:
        return (value as AssetsClaimed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Execution of an XCM message was attempted.
///
/// \[ outcome \]
class Attempted extends Event {
  const Attempted(this.value0);

  factory Attempted._decode(_i1.Input input) {
    return Attempted(_i3.Outcome.codec.decode(input));
  }

  /// xcm::latest::Outcome
  final _i3.Outcome value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Attempted': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Outcome.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Outcome.codec.encodeTo(
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
      other is Attempted && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// A XCM message was sent.
///
/// \[ origin, destination, message \]
class Sent extends Event {
  const Sent(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Sent._decode(_i1.Input input) {
    return Sent(
      _i4.MultiLocation.codec.decode(input),
      _i4.MultiLocation.codec.decode(input),
      const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// MultiLocation
  final _i4.MultiLocation value1;

  /// Xcm<()>
  final _i5.Xcm value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Sent': [
          value0.toJson(),
          value1.toJson(),
          value2.map((value) => value.toJson()).toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i4.MultiLocation.codec.sizeHint(value1);
    size = size + const _i5.XcmCodec().sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value1,
      output,
    );
    const _i1.SequenceCodec<_i13.Instruction>(_i13.Instruction.codec).encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Sent &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          _i14.listsEqual(
            other.value2,
            value2,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Query response received which does not match a registered query. This may be because a
/// matching query was never registered, it may be because it is a duplicate response, or
/// because the query timed out.
///
/// \[ origin location, id \]
class UnexpectedResponse extends Event {
  const UnexpectedResponse(
    this.value0,
    this.value1,
  );

  factory UnexpectedResponse._decode(_i1.Input input) {
    return UnexpectedResponse(
      _i4.MultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// QueryId
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'UnexpectedResponse': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnexpectedResponse &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Query response has been received and is ready for taking with `take_response`. There is
/// no registered notification call.
///
/// \[ id, response \]
class ResponseReady extends Event {
  const ResponseReady(
    this.value0,
    this.value1,
  );

  factory ResponseReady._decode(_i1.Input input) {
    return ResponseReady(
      _i1.U64Codec.codec.decode(input),
      _i6.Response.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt value0;

  /// Response
  final _i6.Response value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'ResponseReady': [
          value0,
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    size = size + _i6.Response.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
    _i6.Response.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ResponseReady &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Query response has been received and query is removed. The registered notification has
/// been dispatched and executed successfully.
///
/// \[ id, pallet index, call index \]
class Notified extends Event {
  const Notified(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Notified._decode(_i1.Input input) {
    return Notified(
      _i1.U64Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt value0;

  /// u8
  final int value1;

  /// u8
  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Notified': [
          value0,
          value1,
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    size = size + _i1.U8Codec.codec.sizeHint(value1);
    size = size + _i1.U8Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Notified &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Query response has been received and query is removed. The registered notification could
/// not be dispatched because the dispatch weight is greater than the maximum weight
/// originally budgeted by this runtime for the query result.
///
/// \[ id, pallet index, call index, actual weight, max budgeted weight \]
class NotifyOverweight extends Event {
  const NotifyOverweight(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  );

  factory NotifyOverweight._decode(_i1.Input input) {
    return NotifyOverweight(
      _i1.U64Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
      _i7.Weight.codec.decode(input),
      _i7.Weight.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt value0;

  /// u8
  final int value1;

  /// u8
  final int value2;

  /// Weight
  final _i7.Weight value3;

  /// Weight
  final _i7.Weight value4;

  @override
  Map<String, List<dynamic>> toJson() => {
        'NotifyOverweight': [
          value0,
          value1,
          value2,
          value3.toJson(),
          value4.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    size = size + _i1.U8Codec.codec.sizeHint(value1);
    size = size + _i1.U8Codec.codec.sizeHint(value2);
    size = size + _i7.Weight.codec.sizeHint(value3);
    size = size + _i7.Weight.codec.sizeHint(value4);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value2,
      output,
    );
    _i7.Weight.codec.encodeTo(
      value3,
      output,
    );
    _i7.Weight.codec.encodeTo(
      value4,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotifyOverweight &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3 &&
          other.value4 == value4;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
        value4,
      );
}

/// Query response has been received and query is removed. There was a general error with
/// dispatching the notification call.
///
/// \[ id, pallet index, call index \]
class NotifyDispatchError extends Event {
  const NotifyDispatchError(
    this.value0,
    this.value1,
    this.value2,
  );

  factory NotifyDispatchError._decode(_i1.Input input) {
    return NotifyDispatchError(
      _i1.U64Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt value0;

  /// u8
  final int value1;

  /// u8
  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'NotifyDispatchError': [
          value0,
          value1,
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    size = size + _i1.U8Codec.codec.sizeHint(value1);
    size = size + _i1.U8Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotifyDispatchError &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Query response has been received and query is removed. The dispatch was unable to be
/// decoded into a `Call`; this might be due to dispatch function having a signature which
/// is not `(origin, QueryId, Response)`.
///
/// \[ id, pallet index, call index \]
class NotifyDecodeFailed extends Event {
  const NotifyDecodeFailed(
    this.value0,
    this.value1,
    this.value2,
  );

  factory NotifyDecodeFailed._decode(_i1.Input input) {
    return NotifyDecodeFailed(
      _i1.U64Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
      _i1.U8Codec.codec.decode(input),
    );
  }

  /// QueryId
  final BigInt value0;

  /// u8
  final int value1;

  /// u8
  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'NotifyDecodeFailed': [
          value0,
          value1,
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    size = size + _i1.U8Codec.codec.sizeHint(value1);
    size = size + _i1.U8Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotifyDecodeFailed &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Expected query response has been received but the origin location of the response does
/// not match that expected. The query remains registered for a later, valid, response to
/// be received and acted upon.
///
/// \[ origin location, id, expected location \]
class InvalidResponder extends Event {
  const InvalidResponder(
    this.value0,
    this.value1,
    this.value2,
  );

  factory InvalidResponder._decode(_i1.Input input) {
    return InvalidResponder(
      _i4.MultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
      const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// QueryId
  final BigInt value1;

  /// Option<MultiLocation>
  final _i4.MultiLocation? value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'InvalidResponder': [
          value0.toJson(),
          value1,
          value2?.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    size = size +
        const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec)
            .sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
    const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvalidResponder &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Expected query response has been received but the expected origin location placed in
/// storage by this runtime previously cannot be decoded. The query remains registered.
///
/// This is unexpected (since a location placed in storage in a previously executing
/// runtime should be readable prior to query timeout) and dangerous since the possibly
/// valid response will be dropped. Manual governance intervention is probably going to be
/// needed.
///
/// \[ origin location, id \]
class InvalidResponderVersion extends Event {
  const InvalidResponderVersion(
    this.value0,
    this.value1,
  );

  factory InvalidResponderVersion._decode(_i1.Input input) {
    return InvalidResponderVersion(
      _i4.MultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// QueryId
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'InvalidResponderVersion': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvalidResponderVersion &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Received query response has been read and removed.
///
/// \[ id \]
class ResponseTaken extends Event {
  const ResponseTaken(this.value0);

  factory ResponseTaken._decode(_i1.Input input) {
    return ResponseTaken(_i1.U64Codec.codec.decode(input));
  }

  /// QueryId
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'ResponseTaken': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is ResponseTaken && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// Some assets have been placed in an asset trap.
///
/// \[ hash, origin, assets \]
class AssetsTrapped extends Event {
  const AssetsTrapped(
    this.value0,
    this.value1,
    this.value2,
  );

  factory AssetsTrapped._decode(_i1.Input input) {
    return AssetsTrapped(
      const _i1.U8ArrayCodec(32).decode(input),
      _i4.MultiLocation.codec.decode(input),
      _i9.VersionedMultiAssets.codec.decode(input),
    );
  }

  /// H256
  final _i8.H256 value0;

  /// MultiLocation
  final _i4.MultiLocation value1;

  /// VersionedMultiAssets
  final _i9.VersionedMultiAssets value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'AssetsTrapped': [
          value0.toList(),
          value1.toJson(),
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i8.H256Codec().sizeHint(value0);
    size = size + _i4.MultiLocation.codec.sizeHint(value1);
    size = size + _i9.VersionedMultiAssets.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value1,
      output,
    );
    _i9.VersionedMultiAssets.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetsTrapped &&
          _i14.listsEqual(
            other.value0,
            value0,
          ) &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// An XCM version change notification message has been attempted to be sent.
///
/// The cost of sending it (borne by the chain) is included.
///
/// \[ destination, result, cost \]
class VersionChangeNotified extends Event {
  const VersionChangeNotified(
    this.value0,
    this.value1,
    this.value2,
  );

  factory VersionChangeNotified._decode(_i1.Input input) {
    return VersionChangeNotified(
      _i4.MultiLocation.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// XcmVersion
  final int value1;

  /// MultiAssets
  final _i10.MultiAssets value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'VersionChangeNotified': [
          value0.toJson(),
          value1,
          value2.map((value) => value.toJson()).toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    size = size + const _i10.MultiAssetsCodec().sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
    const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec).encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VersionChangeNotified &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          _i14.listsEqual(
            other.value2,
            value2,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// The supported version of a location has been changed. This might be through an
/// automatic notification or a manual intervention.
///
/// \[ location, XCM version \]
class SupportedVersionChanged extends Event {
  const SupportedVersionChanged(
    this.value0,
    this.value1,
  );

  factory SupportedVersionChanged._decode(_i1.Input input) {
    return SupportedVersionChanged(
      _i4.MultiLocation.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// XcmVersion
  final int value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'SupportedVersionChanged': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SupportedVersionChanged &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// A given location which had a version change subscription was dropped owing to an error
/// sending the notification to it.
///
/// \[ location, query ID, error \]
class NotifyTargetSendFail extends Event {
  const NotifyTargetSendFail(
    this.value0,
    this.value1,
    this.value2,
  );

  factory NotifyTargetSendFail._decode(_i1.Input input) {
    return NotifyTargetSendFail(
      _i4.MultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
      _i11.Error.codec.decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// QueryId
  final BigInt value1;

  /// XcmError
  final _i11.Error value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'NotifyTargetSendFail': [
          value0.toJson(),
          value1,
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    size = size + _i11.Error.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
    _i11.Error.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotifyTargetSendFail &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// A given location which had a version change subscription was dropped owing to an error
/// migrating the location to our new XCM format.
///
/// \[ location, query ID \]
class NotifyTargetMigrationFail extends Event {
  const NotifyTargetMigrationFail(
    this.value0,
    this.value1,
  );

  factory NotifyTargetMigrationFail._decode(_i1.Input input) {
    return NotifyTargetMigrationFail(
      _i12.VersionedMultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
    );
  }

  /// VersionedMultiLocation
  final _i12.VersionedMultiLocation value0;

  /// QueryId
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'NotifyTargetMigrationFail': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i12.VersionedMultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i12.VersionedMultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotifyTargetMigrationFail &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Expected query response has been received but the expected querier location placed in
/// storage by this runtime previously cannot be decoded. The query remains registered.
///
/// This is unexpected (since a location placed in storage in a previously executing
/// runtime should be readable prior to query timeout) and dangerous since the possibly
/// valid response will be dropped. Manual governance intervention is probably going to be
/// needed.
///
/// \[ origin location, id \]
class InvalidQuerierVersion extends Event {
  const InvalidQuerierVersion(
    this.value0,
    this.value1,
  );

  factory InvalidQuerierVersion._decode(_i1.Input input) {
    return InvalidQuerierVersion(
      _i4.MultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// QueryId
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'InvalidQuerierVersion': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvalidQuerierVersion &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Expected query response has been received but the querier location of the response does
/// not match the expected. The query remains registered for a later, valid, response to
/// be received and acted upon.
///
/// \[ origin location, id, expected querier, maybe actual querier \]
class InvalidQuerier extends Event {
  const InvalidQuerier(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory InvalidQuerier._decode(_i1.Input input) {
    return InvalidQuerier(
      _i4.MultiLocation.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
      _i4.MultiLocation.codec.decode(input),
      const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// QueryId
  final BigInt value1;

  /// MultiLocation
  final _i4.MultiLocation value2;

  /// Option<MultiLocation>
  final _i4.MultiLocation? value3;

  @override
  Map<String, List<dynamic>> toJson() => {
        'InvalidQuerier': [
          value0.toJson(),
          value1,
          value2.toJson(),
          value3?.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    size = size + _i4.MultiLocation.codec.sizeHint(value2);
    size = size +
        const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec)
            .sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      value1,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value2,
      output,
    );
    const _i1.OptionCodec<_i4.MultiLocation>(_i4.MultiLocation.codec).encodeTo(
      value3,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InvalidQuerier &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
      );
}

/// A remote has requested XCM version change notification from us and we have honored it.
/// A version information message is sent to them and its cost is included.
///
/// \[ destination location, cost \]
class VersionNotifyStarted extends Event {
  const VersionNotifyStarted(
    this.value0,
    this.value1,
  );

  factory VersionNotifyStarted._decode(_i1.Input input) {
    return VersionNotifyStarted(
      _i4.MultiLocation.codec.decode(input),
      const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// MultiAssets
  final _i10.MultiAssets value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'VersionNotifyStarted': [
          value0.toJson(),
          value1.map((value) => value.toJson()).toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + const _i10.MultiAssetsCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VersionNotifyStarted &&
          other.value0 == value0 &&
          _i14.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// We have requested that a remote chain sends us XCM version change notifications.
///
/// \[ destination location, cost \]
class VersionNotifyRequested extends Event {
  const VersionNotifyRequested(
    this.value0,
    this.value1,
  );

  factory VersionNotifyRequested._decode(_i1.Input input) {
    return VersionNotifyRequested(
      _i4.MultiLocation.codec.decode(input),
      const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// MultiAssets
  final _i10.MultiAssets value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'VersionNotifyRequested': [
          value0.toJson(),
          value1.map((value) => value.toJson()).toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + const _i10.MultiAssetsCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VersionNotifyRequested &&
          other.value0 == value0 &&
          _i14.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// We have requested that a remote chain stops sending us XCM version change notifications.
///
/// \[ destination location, cost \]
class VersionNotifyUnrequested extends Event {
  const VersionNotifyUnrequested(
    this.value0,
    this.value1,
  );

  factory VersionNotifyUnrequested._decode(_i1.Input input) {
    return VersionNotifyUnrequested(
      _i4.MultiLocation.codec.decode(input),
      const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// MultiAssets
  final _i10.MultiAssets value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'VersionNotifyUnrequested': [
          value0.toJson(),
          value1.map((value) => value.toJson()).toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + const _i10.MultiAssetsCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VersionNotifyUnrequested &&
          other.value0 == value0 &&
          _i14.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Fees were paid from a location for an operation (often for using `SendXcm`).
///
/// \[ paying location, fees \]
class FeesPaid extends Event {
  const FeesPaid(
    this.value0,
    this.value1,
  );

  factory FeesPaid._decode(_i1.Input input) {
    return FeesPaid(
      _i4.MultiLocation.codec.decode(input),
      const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec)
          .decode(input),
    );
  }

  /// MultiLocation
  final _i4.MultiLocation value0;

  /// MultiAssets
  final _i10.MultiAssets value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'FeesPaid': [
          value0.toJson(),
          value1.map((value) => value.toJson()).toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    size = size + const _i10.MultiAssetsCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value0,
      output,
    );
    const _i1.SequenceCodec<_i15.MultiAsset>(_i15.MultiAsset.codec).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FeesPaid &&
          other.value0 == value0 &&
          _i14.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Some assets have been claimed from an asset trap
///
/// \[ hash, origin, assets \]
class AssetsClaimed extends Event {
  const AssetsClaimed(
    this.value0,
    this.value1,
    this.value2,
  );

  factory AssetsClaimed._decode(_i1.Input input) {
    return AssetsClaimed(
      const _i1.U8ArrayCodec(32).decode(input),
      _i4.MultiLocation.codec.decode(input),
      _i9.VersionedMultiAssets.codec.decode(input),
    );
  }

  /// H256
  final _i8.H256 value0;

  /// MultiLocation
  final _i4.MultiLocation value1;

  /// VersionedMultiAssets
  final _i9.VersionedMultiAssets value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'AssetsClaimed': [
          value0.toList(),
          value1.toJson(),
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i8.H256Codec().sizeHint(value0);
    size = size + _i4.MultiLocation.codec.sizeHint(value1);
    size = size + _i9.VersionedMultiAssets.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
      value1,
      output,
    );
    _i9.VersionedMultiAssets.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetsClaimed &&
          _i14.listsEqual(
            other.value0,
            value0,
          ) &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}
