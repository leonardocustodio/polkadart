// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i56;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/auctions.dart' as _i51;
import 'pallets/authorship.dart' as _i10;
import 'pallets/babe.dart' as _i5;
import 'pallets/balances.dart' as _i8;
import 'pallets/bounties.dart' as _i30;
import 'pallets/child_bounties.dart' as _i31;
import 'pallets/claims.dart' as _i25;
import 'pallets/configuration.dart' as _i37;
import 'pallets/conviction_voting.dart' as _i22;
import 'pallets/council.dart' as _i17;
import 'pallets/crowdloan.dart' as _i52;
import 'pallets/democracy.dart' as _i16;
import 'pallets/dmp.dart' as _i44;
import 'pallets/election_provider_multi_phase.dart' as _i33;
import 'pallets/fast_unstake.dart' as _i36;
import 'pallets/grandpa.dart' as _i14;
import 'pallets/hrmp.dart' as _i45;
import 'pallets/identity.dart' as _i27;
import 'pallets/im_online.dart' as _i15;
import 'pallets/indices.dart' as _i7;
import 'pallets/initializer.dart' as _i43;
import 'pallets/message_queue.dart' as _i54;
import 'pallets/multisig.dart' as _i29;
import 'pallets/nomination_pools.dart' as _i35;
import 'pallets/offences.dart' as _i12;
import 'pallets/para_inclusion.dart' as _i39;
import 'pallets/para_inherent.dart' as _i40;
import 'pallets/para_scheduler.dart' as _i41;
import 'pallets/para_session_info.dart' as _i46;
import 'pallets/paras.dart' as _i42;
import 'pallets/paras_disputes.dart' as _i47;
import 'pallets/paras_shared.dart' as _i38;
import 'pallets/paras_slashing.dart' as _i48;
import 'pallets/phragmen_election.dart' as _i19;
import 'pallets/preimage.dart' as _i4;
import 'pallets/proxy.dart' as _i28;
import 'pallets/referenda.dart' as _i23;
import 'pallets/registrar.dart' as _i49;
import 'pallets/scheduler.dart' as _i3;
import 'pallets/session.dart' as _i13;
import 'pallets/slots.dart' as _i50;
import 'pallets/staking.dart' as _i11;
import 'pallets/system.dart' as _i2;
import 'pallets/technical_committee.dart' as _i18;
import 'pallets/technical_membership.dart' as _i20;
import 'pallets/timestamp.dart' as _i6;
import 'pallets/tips.dart' as _i32;
import 'pallets/transaction_payment.dart' as _i9;
import 'pallets/treasury.dart' as _i21;
import 'pallets/utility.dart' as _i55;
import 'pallets/vesting.dart' as _i26;
import 'pallets/voter_list.dart' as _i34;
import 'pallets/whitelist.dart' as _i24;
import 'pallets/xcm_pallet.dart' as _i53;

class Queries {
  Queries(_i1.StateApi api)
      : system = _i2.Queries(api),
        scheduler = _i3.Queries(api),
        preimage = _i4.Queries(api),
        babe = _i5.Queries(api),
        timestamp = _i6.Queries(api),
        indices = _i7.Queries(api),
        balances = _i8.Queries(api),
        transactionPayment = _i9.Queries(api),
        authorship = _i10.Queries(api),
        staking = _i11.Queries(api),
        offences = _i12.Queries(api),
        session = _i13.Queries(api),
        grandpa = _i14.Queries(api),
        imOnline = _i15.Queries(api),
        democracy = _i16.Queries(api),
        council = _i17.Queries(api),
        technicalCommittee = _i18.Queries(api),
        phragmenElection = _i19.Queries(api),
        technicalMembership = _i20.Queries(api),
        treasury = _i21.Queries(api),
        convictionVoting = _i22.Queries(api),
        referenda = _i23.Queries(api),
        whitelist = _i24.Queries(api),
        claims = _i25.Queries(api),
        vesting = _i26.Queries(api),
        identity = _i27.Queries(api),
        proxy = _i28.Queries(api),
        multisig = _i29.Queries(api),
        bounties = _i30.Queries(api),
        childBounties = _i31.Queries(api),
        tips = _i32.Queries(api),
        electionProviderMultiPhase = _i33.Queries(api),
        voterList = _i34.Queries(api),
        nominationPools = _i35.Queries(api),
        fastUnstake = _i36.Queries(api),
        configuration = _i37.Queries(api),
        parasShared = _i38.Queries(api),
        paraInclusion = _i39.Queries(api),
        paraInherent = _i40.Queries(api),
        paraScheduler = _i41.Queries(api),
        paras = _i42.Queries(api),
        initializer = _i43.Queries(api),
        dmp = _i44.Queries(api),
        hrmp = _i45.Queries(api),
        paraSessionInfo = _i46.Queries(api),
        parasDisputes = _i47.Queries(api),
        parasSlashing = _i48.Queries(api),
        registrar = _i49.Queries(api),
        slots = _i50.Queries(api),
        auctions = _i51.Queries(api),
        crowdloan = _i52.Queries(api),
        xcmPallet = _i53.Queries(api),
        messageQueue = _i54.Queries(api);

  final _i2.Queries system;

  final _i3.Queries scheduler;

  final _i4.Queries preimage;

  final _i5.Queries babe;

  final _i6.Queries timestamp;

  final _i7.Queries indices;

  final _i8.Queries balances;

  final _i9.Queries transactionPayment;

  final _i10.Queries authorship;

  final _i11.Queries staking;

  final _i12.Queries offences;

  final _i13.Queries session;

  final _i14.Queries grandpa;

  final _i15.Queries imOnline;

  final _i16.Queries democracy;

  final _i17.Queries council;

  final _i18.Queries technicalCommittee;

  final _i19.Queries phragmenElection;

  final _i20.Queries technicalMembership;

  final _i21.Queries treasury;

  final _i22.Queries convictionVoting;

  final _i23.Queries referenda;

  final _i24.Queries whitelist;

  final _i25.Queries claims;

  final _i26.Queries vesting;

  final _i27.Queries identity;

  final _i28.Queries proxy;

  final _i29.Queries multisig;

  final _i30.Queries bounties;

  final _i31.Queries childBounties;

  final _i32.Queries tips;

  final _i33.Queries electionProviderMultiPhase;

  final _i34.Queries voterList;

  final _i35.Queries nominationPools;

  final _i36.Queries fastUnstake;

  final _i37.Queries configuration;

  final _i38.Queries parasShared;

  final _i39.Queries paraInclusion;

  final _i40.Queries paraInherent;

  final _i41.Queries paraScheduler;

  final _i42.Queries paras;

  final _i43.Queries initializer;

  final _i44.Queries dmp;

  final _i45.Queries hrmp;

  final _i46.Queries paraSessionInfo;

  final _i47.Queries parasDisputes;

  final _i48.Queries parasSlashing;

  final _i49.Queries registrar;

  final _i50.Queries slots;

  final _i51.Queries auctions;

  final _i52.Queries crowdloan;

  final _i53.Queries xcmPallet;

  final _i54.Queries messageQueue;
}

class Extrinsics {
  Extrinsics();

  final _i2.Txs system = _i2.Txs();

  final _i3.Txs scheduler = _i3.Txs();

  final _i4.Txs preimage = _i4.Txs();

  final _i5.Txs babe = _i5.Txs();

  final _i6.Txs timestamp = _i6.Txs();

  final _i7.Txs indices = _i7.Txs();

  final _i8.Txs balances = _i8.Txs();

  final _i11.Txs staking = _i11.Txs();

  final _i13.Txs session = _i13.Txs();

  final _i14.Txs grandpa = _i14.Txs();

  final _i15.Txs imOnline = _i15.Txs();

  final _i16.Txs democracy = _i16.Txs();

  final _i17.Txs council = _i17.Txs();

  final _i18.Txs technicalCommittee = _i18.Txs();

  final _i19.Txs phragmenElection = _i19.Txs();

  final _i20.Txs technicalMembership = _i20.Txs();

  final _i21.Txs treasury = _i21.Txs();

  final _i22.Txs convictionVoting = _i22.Txs();

  final _i23.Txs referenda = _i23.Txs();

  final _i24.Txs whitelist = _i24.Txs();

  final _i25.Txs claims = _i25.Txs();

  final _i26.Txs vesting = _i26.Txs();

  final _i55.Txs utility = _i55.Txs();

  final _i27.Txs identity = _i27.Txs();

  final _i28.Txs proxy = _i28.Txs();

  final _i29.Txs multisig = _i29.Txs();

  final _i30.Txs bounties = _i30.Txs();

  final _i31.Txs childBounties = _i31.Txs();

  final _i32.Txs tips = _i32.Txs();

  final _i33.Txs electionProviderMultiPhase = _i33.Txs();

  final _i34.Txs voterList = _i34.Txs();

  final _i35.Txs nominationPools = _i35.Txs();

  final _i36.Txs fastUnstake = _i36.Txs();

  final _i37.Txs configuration = _i37.Txs();

  final _i40.Txs paraInherent = _i40.Txs();

  final _i42.Txs paras = _i42.Txs();

  final _i43.Txs initializer = _i43.Txs();

  final _i45.Txs hrmp = _i45.Txs();

  final _i47.Txs parasDisputes = _i47.Txs();

  final _i48.Txs parasSlashing = _i48.Txs();

  final _i49.Txs registrar = _i49.Txs();

  final _i50.Txs slots = _i50.Txs();

  final _i51.Txs auctions = _i51.Txs();

  final _i52.Txs crowdloan = _i52.Txs();

  final _i53.Txs xcmPallet = _i53.Txs();

  final _i54.Txs messageQueue = _i54.Txs();
}

class Constants {
  Constants();

  final _i2.Constants system = _i2.Constants();

  final _i3.Constants scheduler = _i3.Constants();

  final _i5.Constants babe = _i5.Constants();

  final _i6.Constants timestamp = _i6.Constants();

  final _i7.Constants indices = _i7.Constants();

  final _i8.Constants balances = _i8.Constants();

  final _i9.Constants transactionPayment = _i9.Constants();

  final _i11.Constants staking = _i11.Constants();

  final _i14.Constants grandpa = _i14.Constants();

  final _i15.Constants imOnline = _i15.Constants();

  final _i16.Constants democracy = _i16.Constants();

  final _i17.Constants council = _i17.Constants();

  final _i18.Constants technicalCommittee = _i18.Constants();

  final _i19.Constants phragmenElection = _i19.Constants();

  final _i21.Constants treasury = _i21.Constants();

  final _i22.Constants convictionVoting = _i22.Constants();

  final _i23.Constants referenda = _i23.Constants();

  final _i25.Constants claims = _i25.Constants();

  final _i26.Constants vesting = _i26.Constants();

  final _i55.Constants utility = _i55.Constants();

  final _i27.Constants identity = _i27.Constants();

  final _i28.Constants proxy = _i28.Constants();

  final _i29.Constants multisig = _i29.Constants();

  final _i30.Constants bounties = _i30.Constants();

  final _i31.Constants childBounties = _i31.Constants();

  final _i32.Constants tips = _i32.Constants();

  final _i33.Constants electionProviderMultiPhase = _i33.Constants();

  final _i34.Constants voterList = _i34.Constants();

  final _i35.Constants nominationPools = _i35.Constants();

  final _i36.Constants fastUnstake = _i36.Constants();

  final _i42.Constants paras = _i42.Constants();

  final _i49.Constants registrar = _i49.Constants();

  final _i50.Constants slots = _i50.Constants();

  final _i51.Constants auctions = _i51.Constants();

  final _i52.Constants crowdloan = _i52.Constants();

  final _i54.Constants messageQueue = _i54.Constants();
}

class Rpc {
  const Rpc({
    required this.state,
    required this.system,
  });

  final _i1.StateApi state;

  final _i1.SystemApi system;
}

class Registry {
  Registry();

  final int extrinsicVersion = 4;

  List getSignedExtensionTypes() {
    return ['CheckMortality', 'CheckNonce', 'ChargeTransactionPayment'];
  }

  List getSignedExtensionExtra() {
    return [
      'CheckSpecVersion',
      'CheckTxVersion',
      'CheckGenesis',
      'CheckMortality'
    ];
  }
}

class Polkadot {
  Polkadot._(
    this._provider,
    this.rpc,
  )   : query = Queries(rpc.state),
        constant = Constants(),
        tx = Extrinsics(),
        registry = Registry();

  factory Polkadot(_i1.Provider provider) {
    final rpc = Rpc(
      state: _i1.StateApi(provider),
      system: _i1.SystemApi(provider),
    );
    return Polkadot._(
      provider,
      rpc,
    );
  }

  factory Polkadot.url(Uri url) {
    final provider = _i1.Provider.fromUri(url);
    return Polkadot(provider);
  }

  final _i1.Provider _provider;

  final Queries query;

  final Constants constant;

  final Rpc rpc;

  final Extrinsics tx;

  final Registry registry;

  _i56.Future connect() async {
    return await _provider.connect();
  }

  _i56.Future disconnect() async {
    return await _provider.disconnect();
  }
}
