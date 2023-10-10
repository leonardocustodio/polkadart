// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'deposit.dart' as _i4;
import 'referendum_status.dart' as _i3;

abstract class ReferendumInfo {
  const ReferendumInfo();

  factory ReferendumInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ReferendumInfoCodec codec = $ReferendumInfoCodec();

  static const $ReferendumInfo values = $ReferendumInfo();

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

class $ReferendumInfo {
  const $ReferendumInfo();

  Ongoing ongoing(_i3.ReferendumStatus value0) {
    return Ongoing(value0);
  }

  Approved approved(
    int value0,
    _i4.Deposit? value1,
    _i4.Deposit? value2,
  ) {
    return Approved(
      value0,
      value1,
      value2,
    );
  }

  Rejected rejected(
    int value0,
    _i4.Deposit? value1,
    _i4.Deposit? value2,
  ) {
    return Rejected(
      value0,
      value1,
      value2,
    );
  }

  Cancelled cancelled(
    int value0,
    _i4.Deposit? value1,
    _i4.Deposit? value2,
  ) {
    return Cancelled(
      value0,
      value1,
      value2,
    );
  }

  TimedOut timedOut(
    int value0,
    _i4.Deposit? value1,
    _i4.Deposit? value2,
  ) {
    return TimedOut(
      value0,
      value1,
      value2,
    );
  }

  Killed killed(int value0) {
    return Killed(value0);
  }
}

class $ReferendumInfoCodec with _i1.Codec<ReferendumInfo> {
  const $ReferendumInfoCodec();

  @override
  ReferendumInfo decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Ongoing._decode(input);
      case 1:
        return Approved._decode(input);
      case 2:
        return Rejected._decode(input);
      case 3:
        return Cancelled._decode(input);
      case 4:
        return TimedOut._decode(input);
      case 5:
        return Killed._decode(input);
      default:
        throw Exception('ReferendumInfo: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ReferendumInfo value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Ongoing:
        (value as Ongoing).encodeTo(output);
        break;
      case Approved:
        (value as Approved).encodeTo(output);
        break;
      case Rejected:
        (value as Rejected).encodeTo(output);
        break;
      case Cancelled:
        (value as Cancelled).encodeTo(output);
        break;
      case TimedOut:
        (value as TimedOut).encodeTo(output);
        break;
      case Killed:
        (value as Killed).encodeTo(output);
        break;
      default:
        throw Exception(
            'ReferendumInfo: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ReferendumInfo value) {
    switch (value.runtimeType) {
      case Ongoing:
        return (value as Ongoing)._sizeHint();
      case Approved:
        return (value as Approved)._sizeHint();
      case Rejected:
        return (value as Rejected)._sizeHint();
      case Cancelled:
        return (value as Cancelled)._sizeHint();
      case TimedOut:
        return (value as TimedOut)._sizeHint();
      case Killed:
        return (value as Killed)._sizeHint();
      default:
        throw Exception(
            'ReferendumInfo: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Ongoing extends ReferendumInfo {
  const Ongoing(this.value0);

  factory Ongoing._decode(_i1.Input input) {
    return Ongoing(_i3.ReferendumStatus.codec.decode(input));
  }

  /// ReferendumStatus<TrackId, RuntimeOrigin, Moment, Call, Balance, Tally,
  ///AccountId, ScheduleAddress,>
  final _i3.ReferendumStatus value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Ongoing': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ReferendumStatus.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ReferendumStatus.codec.encodeTo(
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
      other is Ongoing && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Approved extends ReferendumInfo {
  const Approved(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Approved._decode(_i1.Input input) {
    return Approved(
      _i1.U32Codec.codec.decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
    );
  }

  /// Moment
  final int value0;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value1;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Approved': [
          value0,
          value1?.toJson(),
          value2?.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value1);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
      value1,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
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
      other is Approved &&
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

class Rejected extends ReferendumInfo {
  const Rejected(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Rejected._decode(_i1.Input input) {
    return Rejected(
      _i1.U32Codec.codec.decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
    );
  }

  /// Moment
  final int value0;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value1;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Rejected': [
          value0,
          value1?.toJson(),
          value2?.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value1);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
      value1,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
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
      other is Rejected &&
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

class Cancelled extends ReferendumInfo {
  const Cancelled(
    this.value0,
    this.value1,
    this.value2,
  );

  factory Cancelled._decode(_i1.Input input) {
    return Cancelled(
      _i1.U32Codec.codec.decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
    );
  }

  /// Moment
  final int value0;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value1;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Cancelled': [
          value0,
          value1?.toJson(),
          value2?.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value1);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
      value1,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
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
      other is Cancelled &&
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

class TimedOut extends ReferendumInfo {
  const TimedOut(
    this.value0,
    this.value1,
    this.value2,
  );

  factory TimedOut._decode(_i1.Input input) {
    return TimedOut(
      _i1.U32Codec.codec.decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
      const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).decode(input),
    );
  }

  /// Moment
  final int value0;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value1;

  /// Option<Deposit<AccountId, Balance>>
  final _i4.Deposit? value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'TimedOut': [
          value0,
          value1?.toJson(),
          value2?.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value1);
    size = size +
        const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
      value1,
      output,
    );
    const _i1.OptionCodec<_i4.Deposit>(_i4.Deposit.codec).encodeTo(
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
      other is TimedOut &&
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

class Killed extends ReferendumInfo {
  const Killed(this.value0);

  factory Killed._decode(_i1.Input input) {
    return Killed(_i1.U32Codec.codec.decode(input));
  }

  /// Moment
  final int value0;

  @override
  Map<String, int> toJson() => {'Killed': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Killed && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
