// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../frame_system/pallet/event.dart' as _i3;
import '../pallet_bags_list/pallet/event.dart' as _i33;
import '../pallet_balances/pallet/event.dart' as _i7;
import '../pallet_bounties/pallet/event.dart' as _i29;
import '../pallet_child_bounties/pallet/event.dart' as _i30;
import '../pallet_collective/pallet/event_1.dart' as _i15;
import '../pallet_collective/pallet/event_2.dart' as _i16;
import '../pallet_conviction_voting/pallet/event.dart' as _i20;
import '../pallet_democracy/pallet/event.dart' as _i14;
import '../pallet_election_provider_multi_phase/pallet/event.dart' as _i32;
import '../pallet_elections_phragmen/pallet/event.dart' as _i17;
import '../pallet_fast_unstake/pallet/event.dart' as _i35;
import '../pallet_grandpa/pallet/event.dart' as _i12;
import '../pallet_identity/pallet/event.dart' as _i26;
import '../pallet_im_online/pallet/event.dart' as _i13;
import '../pallet_indices/pallet/event.dart' as _i6;
import '../pallet_membership/pallet/event.dart' as _i18;
import '../pallet_message_queue/pallet/event.dart' as _i45;
import '../pallet_multisig/pallet/event.dart' as _i28;
import '../pallet_nomination_pools/pallet/event.dart' as _i34;
import '../pallet_offences/pallet/event.dart' as _i10;
import '../pallet_preimage/pallet/event.dart' as _i5;
import '../pallet_proxy/pallet/event.dart' as _i27;
import '../pallet_referenda/pallet/event.dart' as _i21;
import '../pallet_scheduler/pallet/event.dart' as _i4;
import '../pallet_session/pallet/event.dart' as _i11;
import '../pallet_staking/pallet/pallet/event.dart' as _i9;
import '../pallet_tips/pallet/event.dart' as _i31;
import '../pallet_transaction_payment/pallet/event.dart' as _i8;
import '../pallet_treasury/pallet/event.dart' as _i19;
import '../pallet_utility/pallet/event.dart' as _i25;
import '../pallet_vesting/pallet/event.dart' as _i24;
import '../pallet_whitelist/pallet/event.dart' as _i22;
import '../pallet_xcm/pallet/event.dart' as _i44;
import '../polkadot_runtime_common/auctions/pallet/event.dart' as _i42;
import '../polkadot_runtime_common/claims/pallet/event.dart' as _i23;
import '../polkadot_runtime_common/crowdloan/pallet/event.dart' as _i43;
import '../polkadot_runtime_common/paras_registrar/pallet/event.dart' as _i40;
import '../polkadot_runtime_common/slots/pallet/event.dart' as _i41;
import '../polkadot_runtime_parachains/disputes/pallet/event.dart' as _i39;
import '../polkadot_runtime_parachains/hrmp/pallet/event.dart' as _i38;
import '../polkadot_runtime_parachains/inclusion/pallet/event.dart' as _i36;
import '../polkadot_runtime_parachains/paras/pallet/event.dart' as _i37;

abstract class RuntimeEvent {
  const RuntimeEvent();

  factory RuntimeEvent.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeEventCodec codec = $RuntimeEventCodec();

  static const $RuntimeEvent values = $RuntimeEvent();

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

class $RuntimeEvent {
  const $RuntimeEvent();

  System system(_i3.Event value0) {
    return System(value0);
  }

  Scheduler scheduler(_i4.Event value0) {
    return Scheduler(value0);
  }

  Preimage preimage(_i5.Event value0) {
    return Preimage(value0);
  }

  Indices indices(_i6.Event value0) {
    return Indices(value0);
  }

  Balances balances(_i7.Event value0) {
    return Balances(value0);
  }

  TransactionPayment transactionPayment(_i8.Event value0) {
    return TransactionPayment(value0);
  }

  Staking staking(_i9.Event value0) {
    return Staking(value0);
  }

  Offences offences(_i10.Event value0) {
    return Offences(value0);
  }

  Session session(_i11.Event value0) {
    return Session(value0);
  }

  Grandpa grandpa(_i12.Event value0) {
    return Grandpa(value0);
  }

  ImOnline imOnline(_i13.Event value0) {
    return ImOnline(value0);
  }

  Democracy democracy(_i14.Event value0) {
    return Democracy(value0);
  }

  Council council(_i15.Event value0) {
    return Council(value0);
  }

  TechnicalCommittee technicalCommittee(_i16.Event value0) {
    return TechnicalCommittee(value0);
  }

  PhragmenElection phragmenElection(_i17.Event value0) {
    return PhragmenElection(value0);
  }

  TechnicalMembership technicalMembership(_i18.Event value0) {
    return TechnicalMembership(value0);
  }

  Treasury treasury(_i19.Event value0) {
    return Treasury(value0);
  }

  ConvictionVoting convictionVoting(_i20.Event value0) {
    return ConvictionVoting(value0);
  }

  Referenda referenda(_i21.Event value0) {
    return Referenda(value0);
  }

  Whitelist whitelist(_i22.Event value0) {
    return Whitelist(value0);
  }

  Claims claims(_i23.Event value0) {
    return Claims(value0);
  }

  Vesting vesting(_i24.Event value0) {
    return Vesting(value0);
  }

  Utility utility(_i25.Event value0) {
    return Utility(value0);
  }

  Identity identity(_i26.Event value0) {
    return Identity(value0);
  }

  Proxy proxy(_i27.Event value0) {
    return Proxy(value0);
  }

  Multisig multisig(_i28.Event value0) {
    return Multisig(value0);
  }

  Bounties bounties(_i29.Event value0) {
    return Bounties(value0);
  }

  ChildBounties childBounties(_i30.Event value0) {
    return ChildBounties(value0);
  }

  Tips tips(_i31.Event value0) {
    return Tips(value0);
  }

  ElectionProviderMultiPhase electionProviderMultiPhase(_i32.Event value0) {
    return ElectionProviderMultiPhase(value0);
  }

  VoterList voterList(_i33.Event value0) {
    return VoterList(value0);
  }

  NominationPools nominationPools(_i34.Event value0) {
    return NominationPools(value0);
  }

  FastUnstake fastUnstake(_i35.Event value0) {
    return FastUnstake(value0);
  }

  ParaInclusion paraInclusion(_i36.Event value0) {
    return ParaInclusion(value0);
  }

  Paras paras(_i37.Event value0) {
    return Paras(value0);
  }

  Hrmp hrmp(_i38.Event value0) {
    return Hrmp(value0);
  }

  ParasDisputes parasDisputes(_i39.Event value0) {
    return ParasDisputes(value0);
  }

  Registrar registrar(_i40.Event value0) {
    return Registrar(value0);
  }

  Slots slots(_i41.Event value0) {
    return Slots(value0);
  }

  Auctions auctions(_i42.Event value0) {
    return Auctions(value0);
  }

  Crowdloan crowdloan(_i43.Event value0) {
    return Crowdloan(value0);
  }

  XcmPallet xcmPallet(_i44.Event value0) {
    return XcmPallet(value0);
  }

  MessageQueue messageQueue(_i45.Event value0) {
    return MessageQueue(value0);
  }
}

class $RuntimeEventCodec with _i1.Codec<RuntimeEvent> {
  const $RuntimeEventCodec();

  @override
  RuntimeEvent decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 1:
        return Scheduler._decode(input);
      case 10:
        return Preimage._decode(input);
      case 4:
        return Indices._decode(input);
      case 5:
        return Balances._decode(input);
      case 32:
        return TransactionPayment._decode(input);
      case 7:
        return Staking._decode(input);
      case 8:
        return Offences._decode(input);
      case 9:
        return Session._decode(input);
      case 11:
        return Grandpa._decode(input);
      case 12:
        return ImOnline._decode(input);
      case 14:
        return Democracy._decode(input);
      case 15:
        return Council._decode(input);
      case 16:
        return TechnicalCommittee._decode(input);
      case 17:
        return PhragmenElection._decode(input);
      case 18:
        return TechnicalMembership._decode(input);
      case 19:
        return Treasury._decode(input);
      case 20:
        return ConvictionVoting._decode(input);
      case 21:
        return Referenda._decode(input);
      case 23:
        return Whitelist._decode(input);
      case 24:
        return Claims._decode(input);
      case 25:
        return Vesting._decode(input);
      case 26:
        return Utility._decode(input);
      case 28:
        return Identity._decode(input);
      case 29:
        return Proxy._decode(input);
      case 30:
        return Multisig._decode(input);
      case 34:
        return Bounties._decode(input);
      case 38:
        return ChildBounties._decode(input);
      case 35:
        return Tips._decode(input);
      case 36:
        return ElectionProviderMultiPhase._decode(input);
      case 37:
        return VoterList._decode(input);
      case 39:
        return NominationPools._decode(input);
      case 40:
        return FastUnstake._decode(input);
      case 53:
        return ParaInclusion._decode(input);
      case 56:
        return Paras._decode(input);
      case 60:
        return Hrmp._decode(input);
      case 62:
        return ParasDisputes._decode(input);
      case 70:
        return Registrar._decode(input);
      case 71:
        return Slots._decode(input);
      case 72:
        return Auctions._decode(input);
      case 73:
        return Crowdloan._decode(input);
      case 99:
        return XcmPallet._decode(input);
      case 100:
        return MessageQueue._decode(input);
      default:
        throw Exception('RuntimeEvent: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeEvent value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case Scheduler:
        (value as Scheduler).encodeTo(output);
        break;
      case Preimage:
        (value as Preimage).encodeTo(output);
        break;
      case Indices:
        (value as Indices).encodeTo(output);
        break;
      case Balances:
        (value as Balances).encodeTo(output);
        break;
      case TransactionPayment:
        (value as TransactionPayment).encodeTo(output);
        break;
      case Staking:
        (value as Staking).encodeTo(output);
        break;
      case Offences:
        (value as Offences).encodeTo(output);
        break;
      case Session:
        (value as Session).encodeTo(output);
        break;
      case Grandpa:
        (value as Grandpa).encodeTo(output);
        break;
      case ImOnline:
        (value as ImOnline).encodeTo(output);
        break;
      case Democracy:
        (value as Democracy).encodeTo(output);
        break;
      case Council:
        (value as Council).encodeTo(output);
        break;
      case TechnicalCommittee:
        (value as TechnicalCommittee).encodeTo(output);
        break;
      case PhragmenElection:
        (value as PhragmenElection).encodeTo(output);
        break;
      case TechnicalMembership:
        (value as TechnicalMembership).encodeTo(output);
        break;
      case Treasury:
        (value as Treasury).encodeTo(output);
        break;
      case ConvictionVoting:
        (value as ConvictionVoting).encodeTo(output);
        break;
      case Referenda:
        (value as Referenda).encodeTo(output);
        break;
      case Whitelist:
        (value as Whitelist).encodeTo(output);
        break;
      case Claims:
        (value as Claims).encodeTo(output);
        break;
      case Vesting:
        (value as Vesting).encodeTo(output);
        break;
      case Utility:
        (value as Utility).encodeTo(output);
        break;
      case Identity:
        (value as Identity).encodeTo(output);
        break;
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case Multisig:
        (value as Multisig).encodeTo(output);
        break;
      case Bounties:
        (value as Bounties).encodeTo(output);
        break;
      case ChildBounties:
        (value as ChildBounties).encodeTo(output);
        break;
      case Tips:
        (value as Tips).encodeTo(output);
        break;
      case ElectionProviderMultiPhase:
        (value as ElectionProviderMultiPhase).encodeTo(output);
        break;
      case VoterList:
        (value as VoterList).encodeTo(output);
        break;
      case NominationPools:
        (value as NominationPools).encodeTo(output);
        break;
      case FastUnstake:
        (value as FastUnstake).encodeTo(output);
        break;
      case ParaInclusion:
        (value as ParaInclusion).encodeTo(output);
        break;
      case Paras:
        (value as Paras).encodeTo(output);
        break;
      case Hrmp:
        (value as Hrmp).encodeTo(output);
        break;
      case ParasDisputes:
        (value as ParasDisputes).encodeTo(output);
        break;
      case Registrar:
        (value as Registrar).encodeTo(output);
        break;
      case Slots:
        (value as Slots).encodeTo(output);
        break;
      case Auctions:
        (value as Auctions).encodeTo(output);
        break;
      case Crowdloan:
        (value as Crowdloan).encodeTo(output);
        break;
      case XcmPallet:
        (value as XcmPallet).encodeTo(output);
        break;
      case MessageQueue:
        (value as MessageQueue).encodeTo(output);
        break;
      default:
        throw Exception(
            'RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeEvent value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case Scheduler:
        return (value as Scheduler)._sizeHint();
      case Preimage:
        return (value as Preimage)._sizeHint();
      case Indices:
        return (value as Indices)._sizeHint();
      case Balances:
        return (value as Balances)._sizeHint();
      case TransactionPayment:
        return (value as TransactionPayment)._sizeHint();
      case Staking:
        return (value as Staking)._sizeHint();
      case Offences:
        return (value as Offences)._sizeHint();
      case Session:
        return (value as Session)._sizeHint();
      case Grandpa:
        return (value as Grandpa)._sizeHint();
      case ImOnline:
        return (value as ImOnline)._sizeHint();
      case Democracy:
        return (value as Democracy)._sizeHint();
      case Council:
        return (value as Council)._sizeHint();
      case TechnicalCommittee:
        return (value as TechnicalCommittee)._sizeHint();
      case PhragmenElection:
        return (value as PhragmenElection)._sizeHint();
      case TechnicalMembership:
        return (value as TechnicalMembership)._sizeHint();
      case Treasury:
        return (value as Treasury)._sizeHint();
      case ConvictionVoting:
        return (value as ConvictionVoting)._sizeHint();
      case Referenda:
        return (value as Referenda)._sizeHint();
      case Whitelist:
        return (value as Whitelist)._sizeHint();
      case Claims:
        return (value as Claims)._sizeHint();
      case Vesting:
        return (value as Vesting)._sizeHint();
      case Utility:
        return (value as Utility)._sizeHint();
      case Identity:
        return (value as Identity)._sizeHint();
      case Proxy:
        return (value as Proxy)._sizeHint();
      case Multisig:
        return (value as Multisig)._sizeHint();
      case Bounties:
        return (value as Bounties)._sizeHint();
      case ChildBounties:
        return (value as ChildBounties)._sizeHint();
      case Tips:
        return (value as Tips)._sizeHint();
      case ElectionProviderMultiPhase:
        return (value as ElectionProviderMultiPhase)._sizeHint();
      case VoterList:
        return (value as VoterList)._sizeHint();
      case NominationPools:
        return (value as NominationPools)._sizeHint();
      case FastUnstake:
        return (value as FastUnstake)._sizeHint();
      case ParaInclusion:
        return (value as ParaInclusion)._sizeHint();
      case Paras:
        return (value as Paras)._sizeHint();
      case Hrmp:
        return (value as Hrmp)._sizeHint();
      case ParasDisputes:
        return (value as ParasDisputes)._sizeHint();
      case Registrar:
        return (value as Registrar)._sizeHint();
      case Slots:
        return (value as Slots)._sizeHint();
      case Auctions:
        return (value as Auctions)._sizeHint();
      case Crowdloan:
        return (value as Crowdloan)._sizeHint();
      case XcmPallet:
        return (value as XcmPallet)._sizeHint();
      case MessageQueue:
        return (value as MessageQueue)._sizeHint();
      default:
        throw Exception(
            'RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends RuntimeEvent {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.Event.codec.decode(input));
  }

  /// frame_system::Event<Runtime>
  final _i3.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'System': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Event.codec.encodeTo(
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
      other is System && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Scheduler extends RuntimeEvent {
  const Scheduler(this.value0);

  factory Scheduler._decode(_i1.Input input) {
    return Scheduler(_i4.Event.codec.decode(input));
  }

  /// pallet_scheduler::Event<Runtime>
  final _i4.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Scheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.Event.codec.encodeTo(
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
      other is Scheduler && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Preimage extends RuntimeEvent {
  const Preimage(this.value0);

  factory Preimage._decode(_i1.Input input) {
    return Preimage(_i5.Event.codec.decode(input));
  }

  /// pallet_preimage::Event<Runtime>
  final _i5.Event value0;

  @override
  Map<String, Map<String, Map<String, List<int>>>> toJson() =>
      {'Preimage': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i5.Event.codec.encodeTo(
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
      other is Preimage && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Indices extends RuntimeEvent {
  const Indices(this.value0);

  factory Indices._decode(_i1.Input input) {
    return Indices(_i6.Event.codec.decode(input));
  }

  /// pallet_indices::Event<Runtime>
  final _i6.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Indices': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i6.Event.codec.encodeTo(
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
      other is Indices && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Balances extends RuntimeEvent {
  const Balances(this.value0);

  factory Balances._decode(_i1.Input input) {
    return Balances(_i7.Event.codec.decode(input));
  }

  /// pallet_balances::Event<Runtime>
  final _i7.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i7.Event.codec.encodeTo(
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
      other is Balances && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class TransactionPayment extends RuntimeEvent {
  const TransactionPayment(this.value0);

  factory TransactionPayment._decode(_i1.Input input) {
    return TransactionPayment(_i8.Event.codec.decode(input));
  }

  /// pallet_transaction_payment::Event<Runtime>
  final _i8.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'TransactionPayment': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i8.Event.codec.encodeTo(
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
      other is TransactionPayment && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Staking extends RuntimeEvent {
  const Staking(this.value0);

  factory Staking._decode(_i1.Input input) {
    return Staking(_i9.Event.codec.decode(input));
  }

  /// pallet_staking::Event<Runtime>
  final _i9.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Staking': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i9.Event.codec.encodeTo(
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
      other is Staking && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Offences extends RuntimeEvent {
  const Offences(this.value0);

  factory Offences._decode(_i1.Input input) {
    return Offences(_i10.Event.codec.decode(input));
  }

  /// pallet_offences::Event
  final _i10.Event value0;

  @override
  Map<String, Map<String, Map<String, List<int>>>> toJson() =>
      {'Offences': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i10.Event.codec.encodeTo(
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
      other is Offences && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Session extends RuntimeEvent {
  const Session(this.value0);

  factory Session._decode(_i1.Input input) {
    return Session(_i11.Event.codec.decode(input));
  }

  /// pallet_session::Event
  final _i11.Event value0;

  @override
  Map<String, Map<String, Map<String, int>>> toJson() =>
      {'Session': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i11.Event.codec.encodeTo(
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
      other is Session && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Grandpa extends RuntimeEvent {
  const Grandpa(this.value0);

  factory Grandpa._decode(_i1.Input input) {
    return Grandpa(_i12.Event.codec.decode(input));
  }

  /// pallet_grandpa::Event
  final _i12.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Grandpa': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i12.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i12.Event.codec.encodeTo(
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
      other is Grandpa && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ImOnline extends RuntimeEvent {
  const ImOnline(this.value0);

  factory ImOnline._decode(_i1.Input input) {
    return ImOnline(_i13.Event.codec.decode(input));
  }

  /// pallet_im_online::Event<Runtime>
  final _i13.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'ImOnline': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i13.Event.codec.encodeTo(
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
      other is ImOnline && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Democracy extends RuntimeEvent {
  const Democracy(this.value0);

  factory Democracy._decode(_i1.Input input) {
    return Democracy(_i14.Event.codec.decode(input));
  }

  /// pallet_democracy::Event<Runtime>
  final _i14.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Democracy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i14.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i14.Event.codec.encodeTo(
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
      other is Democracy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Council extends RuntimeEvent {
  const Council(this.value0);

  factory Council._decode(_i1.Input input) {
    return Council(_i15.Event.codec.decode(input));
  }

  /// pallet_collective::Event<Runtime, pallet_collective::Instance1>
  final _i15.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Council': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i15.Event.codec.encodeTo(
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
      other is Council && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class TechnicalCommittee extends RuntimeEvent {
  const TechnicalCommittee(this.value0);

  factory TechnicalCommittee._decode(_i1.Input input) {
    return TechnicalCommittee(_i16.Event.codec.decode(input));
  }

  /// pallet_collective::Event<Runtime, pallet_collective::Instance2>
  final _i16.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'TechnicalCommittee': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i16.Event.codec.encodeTo(
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
      other is TechnicalCommittee && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PhragmenElection extends RuntimeEvent {
  const PhragmenElection(this.value0);

  factory PhragmenElection._decode(_i1.Input input) {
    return PhragmenElection(_i17.Event.codec.decode(input));
  }

  /// pallet_elections_phragmen::Event<Runtime>
  final _i17.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'PhragmenElection': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i17.Event.codec.encodeTo(
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
      other is PhragmenElection && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class TechnicalMembership extends RuntimeEvent {
  const TechnicalMembership(this.value0);

  factory TechnicalMembership._decode(_i1.Input input) {
    return TechnicalMembership(_i18.Event.codec.decode(input));
  }

  /// pallet_membership::Event<Runtime, pallet_membership::Instance1>
  final _i18.Event value0;

  @override
  Map<String, String> toJson() => {'TechnicalMembership': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i18.Event.codec.encodeTo(
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
      other is TechnicalMembership && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Treasury extends RuntimeEvent {
  const Treasury(this.value0);

  factory Treasury._decode(_i1.Input input) {
    return Treasury(_i19.Event.codec.decode(input));
  }

  /// pallet_treasury::Event<Runtime>
  final _i19.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Treasury': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i19.Event.codec.encodeTo(
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
      other is Treasury && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ConvictionVoting extends RuntimeEvent {
  const ConvictionVoting(this.value0);

  factory ConvictionVoting._decode(_i1.Input input) {
    return ConvictionVoting(_i20.Event.codec.decode(input));
  }

  /// pallet_conviction_voting::Event<Runtime>
  final _i20.Event value0;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() =>
      {'ConvictionVoting': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i20.Event.codec.encodeTo(
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
      other is ConvictionVoting && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Referenda extends RuntimeEvent {
  const Referenda(this.value0);

  factory Referenda._decode(_i1.Input input) {
    return Referenda(_i21.Event.codec.decode(input));
  }

  /// pallet_referenda::Event<Runtime>
  final _i21.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Referenda': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i21.Event.codec.encodeTo(
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
      other is Referenda && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Whitelist extends RuntimeEvent {
  const Whitelist(this.value0);

  factory Whitelist._decode(_i1.Input input) {
    return Whitelist(_i22.Event.codec.decode(input));
  }

  /// pallet_whitelist::Event<Runtime>
  final _i22.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Whitelist': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i22.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i22.Event.codec.encodeTo(
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
      other is Whitelist && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Claims extends RuntimeEvent {
  const Claims(this.value0);

  factory Claims._decode(_i1.Input input) {
    return Claims(_i23.Event.codec.decode(input));
  }

  /// claims::Event<Runtime>
  final _i23.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Claims': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i23.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    _i23.Event.codec.encodeTo(
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
      other is Claims && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Vesting extends RuntimeEvent {
  const Vesting(this.value0);

  factory Vesting._decode(_i1.Input input) {
    return Vesting(_i24.Event.codec.decode(input));
  }

  /// pallet_vesting::Event<Runtime>
  final _i24.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Vesting': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i24.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i24.Event.codec.encodeTo(
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
      other is Vesting && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Utility extends RuntimeEvent {
  const Utility(this.value0);

  factory Utility._decode(_i1.Input input) {
    return Utility(_i25.Event.codec.decode(input));
  }

  /// pallet_utility::Event
  final _i25.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i25.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    _i25.Event.codec.encodeTo(
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
      other is Utility && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Identity extends RuntimeEvent {
  const Identity(this.value0);

  factory Identity._decode(_i1.Input input) {
    return Identity(_i26.Event.codec.decode(input));
  }

  /// pallet_identity::Event<Runtime>
  final _i26.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Identity': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i26.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    _i26.Event.codec.encodeTo(
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
      other is Identity && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Proxy extends RuntimeEvent {
  const Proxy(this.value0);

  factory Proxy._decode(_i1.Input input) {
    return Proxy(_i27.Event.codec.decode(input));
  }

  /// pallet_proxy::Event<Runtime>
  final _i27.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i27.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    _i27.Event.codec.encodeTo(
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
      other is Proxy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Multisig extends RuntimeEvent {
  const Multisig(this.value0);

  factory Multisig._decode(_i1.Input input) {
    return Multisig(_i28.Event.codec.decode(input));
  }

  /// pallet_multisig::Event<Runtime>
  final _i28.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Multisig': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i28.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i28.Event.codec.encodeTo(
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
      other is Multisig && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Bounties extends RuntimeEvent {
  const Bounties(this.value0);

  factory Bounties._decode(_i1.Input input) {
    return Bounties(_i29.Event.codec.decode(input));
  }

  /// pallet_bounties::Event<Runtime>
  final _i29.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Bounties': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i29.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i29.Event.codec.encodeTo(
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
      other is Bounties && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ChildBounties extends RuntimeEvent {
  const ChildBounties(this.value0);

  factory ChildBounties._decode(_i1.Input input) {
    return ChildBounties(_i30.Event.codec.decode(input));
  }

  /// pallet_child_bounties::Event<Runtime>
  final _i30.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'ChildBounties': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i30.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      38,
      output,
    );
    _i30.Event.codec.encodeTo(
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
      other is ChildBounties && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Tips extends RuntimeEvent {
  const Tips(this.value0);

  factory Tips._decode(_i1.Input input) {
    return Tips(_i31.Event.codec.decode(input));
  }

  /// pallet_tips::Event<Runtime>
  final _i31.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Tips': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i31.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i31.Event.codec.encodeTo(
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
      other is Tips && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ElectionProviderMultiPhase extends RuntimeEvent {
  const ElectionProviderMultiPhase(this.value0);

  factory ElectionProviderMultiPhase._decode(_i1.Input input) {
    return ElectionProviderMultiPhase(_i32.Event.codec.decode(input));
  }

  /// pallet_election_provider_multi_phase::Event<Runtime>
  final _i32.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ElectionProviderMultiPhase': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i32.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
    _i32.Event.codec.encodeTo(
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
      other is ElectionProviderMultiPhase && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class VoterList extends RuntimeEvent {
  const VoterList(this.value0);

  factory VoterList._decode(_i1.Input input) {
    return VoterList(_i33.Event.codec.decode(input));
  }

  /// pallet_bags_list::Event<Runtime, pallet_bags_list::Instance1>
  final _i33.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'VoterList': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i33.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
    _i33.Event.codec.encodeTo(
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
      other is VoterList && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class NominationPools extends RuntimeEvent {
  const NominationPools(this.value0);

  factory NominationPools._decode(_i1.Input input) {
    return NominationPools(_i34.Event.codec.decode(input));
  }

  /// pallet_nomination_pools::Event<Runtime>
  final _i34.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'NominationPools': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i34.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      39,
      output,
    );
    _i34.Event.codec.encodeTo(
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
      other is NominationPools && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class FastUnstake extends RuntimeEvent {
  const FastUnstake(this.value0);

  factory FastUnstake._decode(_i1.Input input) {
    return FastUnstake(_i35.Event.codec.decode(input));
  }

  /// pallet_fast_unstake::Event<Runtime>
  final _i35.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'FastUnstake': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i35.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i35.Event.codec.encodeTo(
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
      other is FastUnstake && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ParaInclusion extends RuntimeEvent {
  const ParaInclusion(this.value0);

  factory ParaInclusion._decode(_i1.Input input) {
    return ParaInclusion(_i36.Event.codec.decode(input));
  }

  /// parachains_inclusion::Event<Runtime>
  final _i36.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ParaInclusion': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i36.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      53,
      output,
    );
    _i36.Event.codec.encodeTo(
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
      other is ParaInclusion && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Paras extends RuntimeEvent {
  const Paras(this.value0);

  factory Paras._decode(_i1.Input input) {
    return Paras(_i37.Event.codec.decode(input));
  }

  /// parachains_paras::Event
  final _i37.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Paras': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i37.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      56,
      output,
    );
    _i37.Event.codec.encodeTo(
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
      other is Paras && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Hrmp extends RuntimeEvent {
  const Hrmp(this.value0);

  factory Hrmp._decode(_i1.Input input) {
    return Hrmp(_i38.Event.codec.decode(input));
  }

  /// parachains_hrmp::Event<Runtime>
  final _i38.Event value0;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {'Hrmp': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i38.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
      output,
    );
    _i38.Event.codec.encodeTo(
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
      other is Hrmp && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ParasDisputes extends RuntimeEvent {
  const ParasDisputes(this.value0);

  factory ParasDisputes._decode(_i1.Input input) {
    return ParasDisputes(_i39.Event.codec.decode(input));
  }

  /// parachains_disputes::Event<Runtime>
  final _i39.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'ParasDisputes': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i39.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      62,
      output,
    );
    _i39.Event.codec.encodeTo(
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
      other is ParasDisputes && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Registrar extends RuntimeEvent {
  const Registrar(this.value0);

  factory Registrar._decode(_i1.Input input) {
    return Registrar(_i40.Event.codec.decode(input));
  }

  /// paras_registrar::Event<Runtime>
  final _i40.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Registrar': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i40.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      70,
      output,
    );
    _i40.Event.codec.encodeTo(
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
      other is Registrar && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Slots extends RuntimeEvent {
  const Slots(this.value0);

  factory Slots._decode(_i1.Input input) {
    return Slots(_i41.Event.codec.decode(input));
  }

  /// slots::Event<Runtime>
  final _i41.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Slots': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i41.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      71,
      output,
    );
    _i41.Event.codec.encodeTo(
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
      other is Slots && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Auctions extends RuntimeEvent {
  const Auctions(this.value0);

  factory Auctions._decode(_i1.Input input) {
    return Auctions(_i42.Event.codec.decode(input));
  }

  /// auctions::Event<Runtime>
  final _i42.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Auctions': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i42.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      72,
      output,
    );
    _i42.Event.codec.encodeTo(
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
      other is Auctions && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Crowdloan extends RuntimeEvent {
  const Crowdloan(this.value0);

  factory Crowdloan._decode(_i1.Input input) {
    return Crowdloan(_i43.Event.codec.decode(input));
  }

  /// crowdloan::Event<Runtime>
  final _i43.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'Crowdloan': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i43.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      73,
      output,
    );
    _i43.Event.codec.encodeTo(
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
      other is Crowdloan && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class XcmPallet extends RuntimeEvent {
  const XcmPallet(this.value0);

  factory XcmPallet._decode(_i1.Input input) {
    return XcmPallet(_i44.Event.codec.decode(input));
  }

  /// pallet_xcm::Event<Runtime>
  final _i44.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'XcmPallet': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i44.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      99,
      output,
    );
    _i44.Event.codec.encodeTo(
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
      other is XcmPallet && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class MessageQueue extends RuntimeEvent {
  const MessageQueue(this.value0);

  factory MessageQueue._decode(_i1.Input input) {
    return MessageQueue(_i45.Event.codec.decode(input));
  }

  /// pallet_message_queue::Event<Runtime>
  final _i45.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'MessageQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i45.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      100,
      output,
    );
    _i45.Event.codec.encodeTo(
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
      other is MessageQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
