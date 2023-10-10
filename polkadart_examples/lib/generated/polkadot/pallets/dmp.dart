// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/polkadot_core_primitives/inbound_downward_message.dart' as _i3;
import '../types/polkadot_parachain/primitives/id.dart' as _i2;
import '../types/primitive_types/h256.dart' as _i5;
import '../types/sp_arithmetic/fixed_point/fixed_u128.dart' as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Id, List<_i3.InboundDownwardMessage>>
      _downwardMessageQueues =
      const _i1.StorageMap<_i2.Id, List<_i3.InboundDownwardMessage>>(
    prefix: 'Dmp',
    storage: 'DownwardMessageQueues',
    valueCodec: _i4.SequenceCodec<_i3.InboundDownwardMessage>(
        _i3.InboundDownwardMessage.codec),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  final _i1.StorageMap<_i2.Id, _i5.H256> _downwardMessageQueueHeads =
      const _i1.StorageMap<_i2.Id, _i5.H256>(
    prefix: 'Dmp',
    storage: 'DownwardMessageQueueHeads',
    valueCodec: _i5.H256Codec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  final _i1.StorageMap<_i2.Id, _i6.FixedU128> _deliveryFeeFactor =
      const _i1.StorageMap<_i2.Id, _i6.FixedU128>(
    prefix: 'Dmp',
    storage: 'DeliveryFeeFactor',
    valueCodec: _i6.FixedU128Codec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  /// The downward messages addressed for a certain para.
  _i7.Future<List<_i3.InboundDownwardMessage>> downwardMessageQueues(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _downwardMessageQueues.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _downwardMessageQueues.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// A mapping that stores the downward message queue MQC head for each para.
  ///
  /// Each link in this chain has a form:
  /// `(prev_head, B, H(M))`, where
  /// - `prev_head`: is the previous head hash or zero if none.
  /// - `B`: is the relay-chain block number in which a message was appended.
  /// - `H(M)`: is the hash of the message being appended.
  _i7.Future<_i5.H256> downwardMessageQueueHeads(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _downwardMessageQueueHeads.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _downwardMessageQueueHeads.decodeValue(bytes);
    }
    return List<int>.filled(
      32,
      0,
      growable: false,
    ); /* Default */
  }

  /// The number to multiply the base delivery fee by.
  _i7.Future<_i6.FixedU128> deliveryFeeFactor(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _deliveryFeeFactor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _deliveryFeeFactor.decodeValue(bytes);
    }
    return BigInt.parse(
      '1000000000000000000',
      radix: 10,
    ); /* Default */
  }
}
