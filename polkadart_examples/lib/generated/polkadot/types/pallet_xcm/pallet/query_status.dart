// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../tuples.dart' as _i4;
import '../../xcm/versioned_multi_location.dart' as _i3;
import '../../xcm/versioned_response.dart' as _i5;

abstract class QueryStatus {
  const QueryStatus();

  factory QueryStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $QueryStatusCodec codec = $QueryStatusCodec();

  static const $QueryStatus values = $QueryStatus();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $QueryStatus {
  const $QueryStatus();

  Pending pending({
    required _i3.VersionedMultiLocation responder,
    _i3.VersionedMultiLocation? maybeMatchQuerier,
    _i4.Tuple2<int, int>? maybeNotify,
    required int timeout,
  }) {
    return Pending(
      responder: responder,
      maybeMatchQuerier: maybeMatchQuerier,
      maybeNotify: maybeNotify,
      timeout: timeout,
    );
  }

  VersionNotifier versionNotifier({
    required _i3.VersionedMultiLocation origin,
    required bool isActive,
  }) {
    return VersionNotifier(
      origin: origin,
      isActive: isActive,
    );
  }

  Ready ready({
    required _i5.VersionedResponse response,
    required int at,
  }) {
    return Ready(
      response: response,
      at: at,
    );
  }
}

class $QueryStatusCodec with _i1.Codec<QueryStatus> {
  const $QueryStatusCodec();

  @override
  QueryStatus decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Pending._decode(input);
      case 1:
        return VersionNotifier._decode(input);
      case 2:
        return Ready._decode(input);
      default:
        throw Exception('QueryStatus: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    QueryStatus value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Pending:
        (value as Pending).encodeTo(output);
        break;
      case VersionNotifier:
        (value as VersionNotifier).encodeTo(output);
        break;
      case Ready:
        (value as Ready).encodeTo(output);
        break;
      default:
        throw Exception(
            'QueryStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(QueryStatus value) {
    switch (value.runtimeType) {
      case Pending:
        return (value as Pending)._sizeHint();
      case VersionNotifier:
        return (value as VersionNotifier)._sizeHint();
      case Ready:
        return (value as Ready)._sizeHint();
      default:
        throw Exception(
            'QueryStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Pending extends QueryStatus {
  const Pending({
    required this.responder,
    this.maybeMatchQuerier,
    this.maybeNotify,
    required this.timeout,
  });

  factory Pending._decode(_i1.Input input) {
    return Pending(
      responder: _i3.VersionedMultiLocation.codec.decode(input),
      maybeMatchQuerier: const _i1.OptionCodec<_i3.VersionedMultiLocation>(
              _i3.VersionedMultiLocation.codec)
          .decode(input),
      maybeNotify:
          const _i1.OptionCodec<_i4.Tuple2<int, int>>(_i4.Tuple2Codec<int, int>(
        _i1.U8Codec.codec,
        _i1.U8Codec.codec,
      )).decode(input),
      timeout: _i1.U32Codec.codec.decode(input),
    );
  }

  /// VersionedMultiLocation
  final _i3.VersionedMultiLocation responder;

  /// Option<VersionedMultiLocation>
  final _i3.VersionedMultiLocation? maybeMatchQuerier;

  /// Option<(u8, u8)>
  final _i4.Tuple2<int, int>? maybeNotify;

  /// BlockNumber
  final int timeout;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Pending': {
          'responder': responder.toJson(),
          'maybeMatchQuerier': maybeMatchQuerier?.toJson(),
          'maybeNotify': [
            maybeNotify?.value0,
            maybeNotify?.value1,
          ],
          'timeout': timeout,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(responder);
    size = size +
        const _i1.OptionCodec<_i3.VersionedMultiLocation>(
                _i3.VersionedMultiLocation.codec)
            .sizeHint(maybeMatchQuerier);
    size = size +
        const _i1.OptionCodec<_i4.Tuple2<int, int>>(_i4.Tuple2Codec<int, int>(
          _i1.U8Codec.codec,
          _i1.U8Codec.codec,
        )).sizeHint(maybeNotify);
    size = size + _i1.U32Codec.codec.sizeHint(timeout);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      responder,
      output,
    );
    const _i1.OptionCodec<_i3.VersionedMultiLocation>(
            _i3.VersionedMultiLocation.codec)
        .encodeTo(
      maybeMatchQuerier,
      output,
    );
    const _i1.OptionCodec<_i4.Tuple2<int, int>>(_i4.Tuple2Codec<int, int>(
      _i1.U8Codec.codec,
      _i1.U8Codec.codec,
    )).encodeTo(
      maybeNotify,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      timeout,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Pending &&
          other.responder == responder &&
          other.maybeMatchQuerier == maybeMatchQuerier &&
          other.maybeNotify == maybeNotify &&
          other.timeout == timeout;

  @override
  int get hashCode => Object.hash(
        responder,
        maybeMatchQuerier,
        maybeNotify,
        timeout,
      );
}

class VersionNotifier extends QueryStatus {
  const VersionNotifier({
    required this.origin,
    required this.isActive,
  });

  factory VersionNotifier._decode(_i1.Input input) {
    return VersionNotifier(
      origin: _i3.VersionedMultiLocation.codec.decode(input),
      isActive: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// VersionedMultiLocation
  final _i3.VersionedMultiLocation origin;

  /// bool
  final bool isActive;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VersionNotifier': {
          'origin': origin.toJson(),
          'isActive': isActive,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(origin);
    size = size + _i1.BoolCodec.codec.sizeHint(isActive);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      origin,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isActive,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VersionNotifier &&
          other.origin == origin &&
          other.isActive == isActive;

  @override
  int get hashCode => Object.hash(
        origin,
        isActive,
      );
}

class Ready extends QueryStatus {
  const Ready({
    required this.response,
    required this.at,
  });

  factory Ready._decode(_i1.Input input) {
    return Ready(
      response: _i5.VersionedResponse.codec.decode(input),
      at: _i1.U32Codec.codec.decode(input),
    );
  }

  /// VersionedResponse
  final _i5.VersionedResponse response;

  /// BlockNumber
  final int at;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Ready': {
          'response': response.toJson(),
          'at': at,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.VersionedResponse.codec.sizeHint(response);
    size = size + _i1.U32Codec.codec.sizeHint(at);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i5.VersionedResponse.codec.encodeTo(
      response,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      at,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Ready && other.response == response && other.at == at;

  @override
  int get hashCode => Object.hash(
        response,
        at,
      );
}
