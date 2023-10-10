// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/polkadot_core_primitives/inbound_hrmp_message.dart' as _i7;
import '../types/polkadot_parachain/primitives/hrmp_channel_id.dart' as _i2;
import '../types/polkadot_parachain/primitives/id.dart' as _i5;
import '../types/polkadot_runtime/runtime_call.dart' as _i10;
import '../types/polkadot_runtime_parachains/hrmp/hrmp_channel.dart' as _i6;
import '../types/polkadot_runtime_parachains/hrmp/hrmp_open_channel_request.dart'
    as _i3;
import '../types/polkadot_runtime_parachains/hrmp/pallet/call.dart' as _i11;
import '../types/tuples.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.HrmpChannelId, _i3.HrmpOpenChannelRequest>
      _hrmpOpenChannelRequests =
      const _i1.StorageMap<_i2.HrmpChannelId, _i3.HrmpOpenChannelRequest>(
    prefix: 'Hrmp',
    storage: 'HrmpOpenChannelRequests',
    valueCodec: _i3.HrmpOpenChannelRequest.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.HrmpChannelId.codec),
  );

  final _i1.StorageValue<List<_i2.HrmpChannelId>> _hrmpOpenChannelRequestsList =
      const _i1.StorageValue<List<_i2.HrmpChannelId>>(
    prefix: 'Hrmp',
    storage: 'HrmpOpenChannelRequestsList',
    valueCodec: _i4.SequenceCodec<_i2.HrmpChannelId>(_i2.HrmpChannelId.codec),
  );

  final _i1.StorageMap<_i5.Id, int> _hrmpOpenChannelRequestCount =
      const _i1.StorageMap<_i5.Id, int>(
    prefix: 'Hrmp',
    storage: 'HrmpOpenChannelRequestCount',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, int> _hrmpAcceptedChannelRequestCount =
      const _i1.StorageMap<_i5.Id, int>(
    prefix: 'Hrmp',
    storage: 'HrmpAcceptedChannelRequestCount',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i2.HrmpChannelId, dynamic> _hrmpCloseChannelRequests =
      const _i1.StorageMap<_i2.HrmpChannelId, dynamic>(
    prefix: 'Hrmp',
    storage: 'HrmpCloseChannelRequests',
    valueCodec: _i4.NullCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.HrmpChannelId.codec),
  );

  final _i1.StorageValue<List<_i2.HrmpChannelId>>
      _hrmpCloseChannelRequestsList =
      const _i1.StorageValue<List<_i2.HrmpChannelId>>(
    prefix: 'Hrmp',
    storage: 'HrmpCloseChannelRequestsList',
    valueCodec: _i4.SequenceCodec<_i2.HrmpChannelId>(_i2.HrmpChannelId.codec),
  );

  final _i1.StorageMap<_i5.Id, int> _hrmpWatermarks =
      const _i1.StorageMap<_i5.Id, int>(
    prefix: 'Hrmp',
    storage: 'HrmpWatermarks',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i2.HrmpChannelId, _i6.HrmpChannel> _hrmpChannels =
      const _i1.StorageMap<_i2.HrmpChannelId, _i6.HrmpChannel>(
    prefix: 'Hrmp',
    storage: 'HrmpChannels',
    valueCodec: _i6.HrmpChannel.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.HrmpChannelId.codec),
  );

  final _i1.StorageMap<_i5.Id, List<_i5.Id>> _hrmpIngressChannelsIndex =
      const _i1.StorageMap<_i5.Id, List<_i5.Id>>(
    prefix: 'Hrmp',
    storage: 'HrmpIngressChannelsIndex',
    valueCodec: _i4.SequenceCodec<_i5.Id>(_i5.IdCodec()),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, List<_i5.Id>> _hrmpEgressChannelsIndex =
      const _i1.StorageMap<_i5.Id, List<_i5.Id>>(
    prefix: 'Hrmp',
    storage: 'HrmpEgressChannelsIndex',
    valueCodec: _i4.SequenceCodec<_i5.Id>(_i5.IdCodec()),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i2.HrmpChannelId, List<_i7.InboundHrmpMessage>>
      _hrmpChannelContents =
      const _i1.StorageMap<_i2.HrmpChannelId, List<_i7.InboundHrmpMessage>>(
    prefix: 'Hrmp',
    storage: 'HrmpChannelContents',
    valueCodec:
        _i4.SequenceCodec<_i7.InboundHrmpMessage>(_i7.InboundHrmpMessage.codec),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.HrmpChannelId.codec),
  );

  final _i1.StorageMap<_i5.Id, List<_i8.Tuple2<int, List<_i5.Id>>>>
      _hrmpChannelDigests =
      const _i1.StorageMap<_i5.Id, List<_i8.Tuple2<int, List<_i5.Id>>>>(
    prefix: 'Hrmp',
    storage: 'HrmpChannelDigests',
    valueCodec: _i4.SequenceCodec<_i8.Tuple2<int, List<_i5.Id>>>(
        _i8.Tuple2Codec<int, List<_i5.Id>>(
      _i4.U32Codec.codec,
      _i4.SequenceCodec<_i5.Id>(_i5.IdCodec()),
    )),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  /// The set of pending HRMP open channel requests.
  ///
  /// The set is accompanied by a list for iteration.
  ///
  /// Invariant:
  /// - There are no channels that exists in list but not in the set and vice versa.
  _i9.Future<_i3.HrmpOpenChannelRequest?> hrmpOpenChannelRequests(
    _i2.HrmpChannelId key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpOpenChannelRequests.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpOpenChannelRequests.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i9.Future<List<_i2.HrmpChannelId>> hrmpOpenChannelRequestsList(
      {_i1.BlockHash? at}) async {
    final hashedKey = _hrmpOpenChannelRequestsList.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpOpenChannelRequestsList.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// This mapping tracks how many open channel requests are initiated by a given sender para.
  /// Invariant: `HrmpOpenChannelRequests` should contain the same number of items that has
  /// `(X, _)` as the number of `HrmpOpenChannelRequestCount` for `X`.
  _i9.Future<int> hrmpOpenChannelRequestCount(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpOpenChannelRequestCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpOpenChannelRequestCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// This mapping tracks how many open channel requests were accepted by a given recipient para.
  /// Invariant: `HrmpOpenChannelRequests` should contain the same number of items `(_, X)` with
  /// `confirmed` set to true, as the number of `HrmpAcceptedChannelRequestCount` for `X`.
  _i9.Future<int> hrmpAcceptedChannelRequestCount(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpAcceptedChannelRequestCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpAcceptedChannelRequestCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// A set of pending HRMP close channel requests that are going to be closed during the session
  /// change. Used for checking if a given channel is registered for closure.
  ///
  /// The set is accompanied by a list for iteration.
  ///
  /// Invariant:
  /// - There are no channels that exists in list but not in the set and vice versa.
  _i9.Future<dynamic> hrmpCloseChannelRequests(
    _i2.HrmpChannelId key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpCloseChannelRequests.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpCloseChannelRequests.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i9.Future<List<_i2.HrmpChannelId>> hrmpCloseChannelRequestsList(
      {_i1.BlockHash? at}) async {
    final hashedKey = _hrmpCloseChannelRequestsList.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpCloseChannelRequestsList.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The HRMP watermark associated with each para.
  /// Invariant:
  /// - each para `P` used here as a key should satisfy `Paras::is_valid_para(P)` within a session.
  _i9.Future<int?> hrmpWatermarks(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpWatermarks.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpWatermarks.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// HRMP channel data associated with each para.
  /// Invariant:
  /// - each participant in the channel should satisfy `Paras::is_valid_para(P)` within a session.
  _i9.Future<_i6.HrmpChannel?> hrmpChannels(
    _i2.HrmpChannelId key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpChannels.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpChannels.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Ingress/egress indexes allow to find all the senders and receivers given the opposite side.
  /// I.e.
  ///
  /// (a) ingress index allows to find all the senders for a given recipient.
  /// (b) egress index allows to find all the recipients for a given sender.
  ///
  /// Invariants:
  /// - for each ingress index entry for `P` each item `I` in the index should present in
  ///   `HrmpChannels` as `(I, P)`.
  /// - for each egress index entry for `P` each item `E` in the index should present in
  ///   `HrmpChannels` as `(P, E)`.
  /// - there should be no other dangling channels in `HrmpChannels`.
  /// - the vectors are sorted.
  _i9.Future<List<_i5.Id>> hrmpIngressChannelsIndex(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpIngressChannelsIndex.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpIngressChannelsIndex.decodeValue(bytes);
    }
    return []; /* Default */
  }

  _i9.Future<List<_i5.Id>> hrmpEgressChannelsIndex(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpEgressChannelsIndex.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpEgressChannelsIndex.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Storage for the messages for each channel.
  /// Invariant: cannot be non-empty if the corresponding channel in `HrmpChannels` is `None`.
  _i9.Future<List<_i7.InboundHrmpMessage>> hrmpChannelContents(
    _i2.HrmpChannelId key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpChannelContents.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpChannelContents.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Maintains a mapping that can be used to answer the question: What paras sent a message at
  /// the given block number for a given receiver. Invariants:
  /// - The inner `Vec<ParaId>` is never empty.
  /// - The inner `Vec<ParaId>` cannot store two same `ParaId`.
  /// - The outer vector is sorted ascending by block number and cannot store two items with the
  ///   same block number.
  _i9.Future<List<_i8.Tuple2<int, List<_i5.Id>>>> hrmpChannelDigests(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _hrmpChannelDigests.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hrmpChannelDigests.decodeValue(bytes);
    }
    return []; /* Default */
  }
}

class Txs {
  const Txs();

  /// Initiate opening a channel from a parachain to a given recipient with given channel
  /// parameters.
  ///
  /// - `proposed_max_capacity` - specifies how many messages can be in the channel at once.
  /// - `proposed_max_message_size` - specifies the maximum size of the messages.
  ///
  /// These numbers are a subject to the relay-chain configuration limits.
  ///
  /// The channel can be opened only after the recipient confirms it and only on a session
  /// change.
  _i10.RuntimeCall hrmpInitOpenChannel({
    required recipient,
    required proposedMaxCapacity,
    required proposedMaxMessageSize,
  }) {
    final _call = _i11.Call.values.hrmpInitOpenChannel(
      recipient: recipient,
      proposedMaxCapacity: proposedMaxCapacity,
      proposedMaxMessageSize: proposedMaxMessageSize,
    );
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// Accept a pending open channel request from the given sender.
  ///
  /// The channel will be opened only on the next session boundary.
  _i10.RuntimeCall hrmpAcceptOpenChannel({required sender}) {
    final _call = _i11.Call.values.hrmpAcceptOpenChannel(sender: sender);
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// Initiate unilateral closing of a channel. The origin must be either the sender or the
  /// recipient in the channel being closed.
  ///
  /// The closure can only happen on a session change.
  _i10.RuntimeCall hrmpCloseChannel({required channelId}) {
    final _call = _i11.Call.values.hrmpCloseChannel(channelId: channelId);
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// This extrinsic triggers the cleanup of all the HRMP storage items that
  /// a para may have. Normally this happens once per session, but this allows
  /// you to trigger the cleanup immediately for a specific parachain.
  ///
  /// Origin must be Root.
  ///
  /// Number of inbound and outbound channels for `para` must be provided as witness data of weighing.
  _i10.RuntimeCall forceCleanHrmp({
    required para,
    required inbound,
    required outbound,
  }) {
    final _call = _i11.Call.values.forceCleanHrmp(
      para: para,
      inbound: inbound,
      outbound: outbound,
    );
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// Force process HRMP open channel requests.
  ///
  /// If there are pending HRMP open channel requests, you can use this
  /// function process all of those requests immediately.
  ///
  /// Total number of opening channels must be provided as witness data of weighing.
  _i10.RuntimeCall forceProcessHrmpOpen({required channels}) {
    final _call = _i11.Call.values.forceProcessHrmpOpen(channels: channels);
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// Force process HRMP close channel requests.
  ///
  /// If there are pending HRMP close channel requests, you can use this
  /// function process all of those requests immediately.
  ///
  /// Total number of closing channels must be provided as witness data of weighing.
  _i10.RuntimeCall forceProcessHrmpClose({required channels}) {
    final _call = _i11.Call.values.forceProcessHrmpClose(channels: channels);
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// This cancels a pending open channel request. It can be canceled by either of the sender
  /// or the recipient for that request. The origin must be either of those.
  ///
  /// The cancellation happens immediately. It is not possible to cancel the request if it is
  /// already accepted.
  ///
  /// Total number of open requests (i.e. `HrmpOpenChannelRequestsList`) must be provided as
  /// witness data.
  _i10.RuntimeCall hrmpCancelOpenRequest({
    required channelId,
    required openRequests,
  }) {
    final _call = _i11.Call.values.hrmpCancelOpenRequest(
      channelId: channelId,
      openRequests: openRequests,
    );
    return _i10.RuntimeCall.values.hrmp(_call);
  }

  /// Open a channel from a `sender` to a `recipient` `ParaId` using the Root origin. Although
  /// opened by Root, the `max_capacity` and `max_message_size` are still subject to the Relay
  /// Chain's configured limits.
  ///
  /// Expected use is when one of the `ParaId`s involved in the channel is governed by the
  /// Relay Chain, e.g. a common good parachain.
  _i10.RuntimeCall forceOpenHrmpChannel({
    required sender,
    required recipient,
    required maxCapacity,
    required maxMessageSize,
  }) {
    final _call = _i11.Call.values.forceOpenHrmpChannel(
      sender: sender,
      recipient: recipient,
      maxCapacity: maxCapacity,
      maxMessageSize: maxMessageSize,
    );
    return _i10.RuntimeCall.values.hrmp(_call);
  }
}
