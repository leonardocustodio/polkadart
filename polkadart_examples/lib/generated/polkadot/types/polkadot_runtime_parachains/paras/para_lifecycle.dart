// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ParaLifecycle {
  onboarding('Onboarding', 0),
  parathread('Parathread', 1),
  parachain('Parachain', 2),
  upgradingParathread('UpgradingParathread', 3),
  downgradingParachain('DowngradingParachain', 4),
  offboardingParathread('OffboardingParathread', 5),
  offboardingParachain('OffboardingParachain', 6);

  const ParaLifecycle(
    this.variantName,
    this.codecIndex,
  );

  factory ParaLifecycle.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ParaLifecycleCodec codec = $ParaLifecycleCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ParaLifecycleCodec with _i1.Codec<ParaLifecycle> {
  const $ParaLifecycleCodec();

  @override
  ParaLifecycle decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ParaLifecycle.onboarding;
      case 1:
        return ParaLifecycle.parathread;
      case 2:
        return ParaLifecycle.parachain;
      case 3:
        return ParaLifecycle.upgradingParathread;
      case 4:
        return ParaLifecycle.downgradingParachain;
      case 5:
        return ParaLifecycle.offboardingParathread;
      case 6:
        return ParaLifecycle.offboardingParachain;
      default:
        throw Exception('ParaLifecycle: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ParaLifecycle value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
