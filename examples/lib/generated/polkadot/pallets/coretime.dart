// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../types/pallet_broker/coretime_interface/core_assignment.dart' as _i4;
import '../types/polkadot_runtime/runtime_call.dart' as _i1;
import '../types/polkadot_runtime_parachains/assigner_coretime/parts_of57600.dart'
    as _i5;
import '../types/polkadot_runtime_parachains/coretime/pallet/call.dart' as _i2;
import '../types/staging_xcm/v4/junction/junction.dart' as _i7;
import '../types/staging_xcm/v4/junctions/junctions.dart' as _i6;
import '../types/tuples.dart' as _i3;

class Txs {
  const Txs();

  /// Request the configuration to be updated with the specified number of cores. Warning:
  /// Since this only schedules a configuration update, it takes two sessions to come into
  /// effect.
  ///
  /// - `origin`: Root or the Coretime Chain
  /// - `count`: total number of cores
  _i1.RuntimeCall requestCoreCount({required int count}) {
    final _call = _i2.Call.values.requestCoreCount(count: count);
    return _i1.RuntimeCall.values.coretime(_call);
  }

  /// Request to claim the instantaneous coretime sales revenue starting from the block it was
  /// last claimed until and up to the block specified. The claimed amount value is sent back
  /// to the Coretime chain in a `notify_revenue` message. At the same time, the amount is
  /// teleported to the Coretime chain.
  _i1.RuntimeCall requestRevenueAt({required int when}) {
    final _call = _i2.Call.values.requestRevenueAt(when: when);
    return _i1.RuntimeCall.values.coretime(_call);
  }

  /// Receive instructions from the `ExternalBrokerOrigin`, detailing how a specific core is
  /// to be used.
  ///
  /// Parameters:
  /// -`origin`: The `ExternalBrokerOrigin`, assumed to be the coretime chain.
  /// -`core`: The core that should be scheduled.
  /// -`begin`: The starting blockheight of the instruction.
  /// -`assignment`: How the blockspace should be utilised.
  /// -`end_hint`: An optional hint as to when this particular set of instructions will end.
  _i1.RuntimeCall assignCore({
    required int core,
    required int begin,
    required List<_i3.Tuple2<_i4.CoreAssignment, _i5.PartsOf57600>> assignment,
    int? endHint,
  }) {
    final _call = _i2.Call.values.assignCore(
      core: core,
      begin: begin,
      assignment: assignment,
      endHint: endHint,
    );
    return _i1.RuntimeCall.values.coretime(_call);
  }
}

class Constants {
  Constants();

  /// The ParaId of the coretime chain.
  final int brokerId = 1005;

  /// The coretime chain pot location.
  final _i6.Junctions brokerPotLocation = const _i6.X1([
    _i7.AccountId32(
      network: null,
      id: <int>[
        109,
        111,
        100,
        108,
        112,
        121,
        47,
        98,
        114,
        111,
        107,
        101,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ],
    )
  ]);
}
