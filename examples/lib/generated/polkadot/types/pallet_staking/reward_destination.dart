// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i3;

abstract class RewardDestination {
  const RewardDestination();

  factory RewardDestination.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RewardDestinationCodec codec = $RewardDestinationCodec();

  static const $RewardDestination values = $RewardDestination();

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

class $RewardDestination {
  const $RewardDestination();

  Staked staked() {
    return Staked();
  }

  Stash stash() {
    return Stash();
  }

  Controller controller() {
    return Controller();
  }

  Account account(_i3.AccountId32 value0) {
    return Account(value0);
  }

  None none() {
    return None();
  }
}

class $RewardDestinationCodec with _i1.Codec<RewardDestination> {
  const $RewardDestinationCodec();

  @override
  RewardDestination decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Staked();
      case 1:
        return const Stash();
      case 2:
        return const Controller();
      case 3:
        return Account._decode(input);
      case 4:
        return const None();
      default:
        throw Exception('RewardDestination: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RewardDestination value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Staked:
        (value as Staked).encodeTo(output);
        break;
      case Stash:
        (value as Stash).encodeTo(output);
        break;
      case Controller:
        (value as Controller).encodeTo(output);
        break;
      case Account:
        (value as Account).encodeTo(output);
        break;
      case None:
        (value as None).encodeTo(output);
        break;
      default:
        throw Exception(
            'RewardDestination: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RewardDestination value) {
    switch (value.runtimeType) {
      case Staked:
        return 1;
      case Stash:
        return 1;
      case Controller:
        return 1;
      case Account:
        return (value as Account)._sizeHint();
      case None:
        return 1;
      default:
        throw Exception(
            'RewardDestination: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Staked extends RewardDestination {
  const Staked();

  @override
  Map<String, dynamic> toJson() => {'Staked': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Staked;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Stash extends RewardDestination {
  const Stash();

  @override
  Map<String, dynamic> toJson() => {'Stash': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Stash;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Controller extends RewardDestination {
  const Controller();

  @override
  Map<String, dynamic> toJson() => {'Controller': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Controller;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Account extends RewardDestination {
  const Account(this.value0);

  factory Account._decode(_i1.Input input) {
    return Account(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// AccountId
  final _i3.AccountId32 value0;

  @override
  Map<String, List<int>> toJson() => {'Account': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
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
      other is Account &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class None extends RewardDestination {
  const None();

  @override
  Map<String, dynamic> toJson() => {'None': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is None;

  @override
  int get hashCode => runtimeType.hashCode;
}
