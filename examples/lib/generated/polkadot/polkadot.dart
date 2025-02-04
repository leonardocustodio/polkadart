// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i59;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/asset_rate.dart' as _i53;
import 'pallets/auctions.dart' as _i48;
import 'pallets/authority_discovery.dart' as _i16;
import 'pallets/authorship.dart' as _i10;
import 'pallets/babe.dart' as _i5;
import 'pallets/balances.dart' as _i8;
import 'pallets/beefy.dart' as _i54;
import 'pallets/beefy_mmr_leaf.dart' as _i56;
import 'pallets/bounties.dart' as _i26;
import 'pallets/child_bounties.dart' as _i27;
import 'pallets/claims.dart' as _i22;
import 'pallets/configuration.dart' as _i32;
import 'pallets/conviction_voting.dart' as _i18;
import 'pallets/coretime.dart' as _i58;
import 'pallets/coretime_assignment_provider.dart' as _i45;
import 'pallets/crowdloan.dart' as _i49;
import 'pallets/dmp.dart' as _i39;
import 'pallets/election_provider_multi_phase.dart' as _i28;
import 'pallets/fast_unstake.dart' as _i31;
import 'pallets/grandpa.dart' as _i15;
import 'pallets/historical.dart' as _i13;
import 'pallets/hrmp.dart' as _i40;
import 'pallets/indices.dart' as _i7;
import 'pallets/initializer.dart' as _i38;
import 'pallets/message_queue.dart' as _i52;
import 'pallets/mmr.dart' as _i55;
import 'pallets/multisig.dart' as _i25;
import 'pallets/nomination_pools.dart' as _i30;
import 'pallets/offences.dart' as _i12;
import 'pallets/on_demand.dart' as _i44;
import 'pallets/para_inclusion.dart' as _i34;
import 'pallets/para_inherent.dart' as _i35;
import 'pallets/para_scheduler.dart' as _i36;
import 'pallets/para_session_info.dart' as _i41;
import 'pallets/parameters.dart' as _i21;
import 'pallets/paras.dart' as _i37;
import 'pallets/paras_disputes.dart' as _i42;
import 'pallets/paras_shared.dart' as _i33;
import 'pallets/paras_slashing.dart' as _i43;
import 'pallets/preimage.dart' as _i4;
import 'pallets/proxy.dart' as _i24;
import 'pallets/referenda.dart' as _i19;
import 'pallets/registrar.dart' as _i46;
import 'pallets/scheduler.dart' as _i3;
import 'pallets/session.dart' as _i14;
import 'pallets/slots.dart' as _i47;
import 'pallets/staking.dart' as _i11;
import 'pallets/state_trie_migration.dart' as _i50;
import 'pallets/system.dart' as _i2;
import 'pallets/timestamp.dart' as _i6;
import 'pallets/transaction_payment.dart' as _i9;
import 'pallets/treasury.dart' as _i17;
import 'pallets/utility.dart' as _i57;
import 'pallets/vesting.dart' as _i23;
import 'pallets/voter_list.dart' as _i29;
import 'pallets/whitelist.dart' as _i20;
import 'pallets/xcm_pallet.dart' as _i51;

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
        historical = _i13.Queries(api),
        session = _i14.Queries(api),
        grandpa = _i15.Queries(api),
        authorityDiscovery = _i16.Queries(api),
        treasury = _i17.Queries(api),
        convictionVoting = _i18.Queries(api),
        referenda = _i19.Queries(api),
        whitelist = _i20.Queries(api),
        parameters = _i21.Queries(api),
        claims = _i22.Queries(api),
        vesting = _i23.Queries(api),
        proxy = _i24.Queries(api),
        multisig = _i25.Queries(api),
        bounties = _i26.Queries(api),
        childBounties = _i27.Queries(api),
        electionProviderMultiPhase = _i28.Queries(api),
        voterList = _i29.Queries(api),
        nominationPools = _i30.Queries(api),
        fastUnstake = _i31.Queries(api),
        configuration = _i32.Queries(api),
        parasShared = _i33.Queries(api),
        paraInclusion = _i34.Queries(api),
        paraInherent = _i35.Queries(api),
        paraScheduler = _i36.Queries(api),
        paras = _i37.Queries(api),
        initializer = _i38.Queries(api),
        dmp = _i39.Queries(api),
        hrmp = _i40.Queries(api),
        paraSessionInfo = _i41.Queries(api),
        parasDisputes = _i42.Queries(api),
        parasSlashing = _i43.Queries(api),
        onDemand = _i44.Queries(api),
        coretimeAssignmentProvider = _i45.Queries(api),
        registrar = _i46.Queries(api),
        slots = _i47.Queries(api),
        auctions = _i48.Queries(api),
        crowdloan = _i49.Queries(api),
        stateTrieMigration = _i50.Queries(api),
        xcmPallet = _i51.Queries(api),
        messageQueue = _i52.Queries(api),
        assetRate = _i53.Queries(api),
        beefy = _i54.Queries(api),
        mmr = _i55.Queries(api),
        beefyMmrLeaf = _i56.Queries(api);

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

  final _i13.Queries historical;

  final _i14.Queries session;

  final _i15.Queries grandpa;

  final _i16.Queries authorityDiscovery;

  final _i17.Queries treasury;

  final _i18.Queries convictionVoting;

  final _i19.Queries referenda;

  final _i20.Queries whitelist;

  final _i21.Queries parameters;

  final _i22.Queries claims;

  final _i23.Queries vesting;

  final _i24.Queries proxy;

  final _i25.Queries multisig;

  final _i26.Queries bounties;

  final _i27.Queries childBounties;

  final _i28.Queries electionProviderMultiPhase;

  final _i29.Queries voterList;

  final _i30.Queries nominationPools;

  final _i31.Queries fastUnstake;

  final _i32.Queries configuration;

  final _i33.Queries parasShared;

  final _i34.Queries paraInclusion;

  final _i35.Queries paraInherent;

  final _i36.Queries paraScheduler;

  final _i37.Queries paras;

  final _i38.Queries initializer;

  final _i39.Queries dmp;

  final _i40.Queries hrmp;

  final _i41.Queries paraSessionInfo;

  final _i42.Queries parasDisputes;

  final _i43.Queries parasSlashing;

  final _i44.Queries onDemand;

  final _i45.Queries coretimeAssignmentProvider;

  final _i46.Queries registrar;

  final _i47.Queries slots;

  final _i48.Queries auctions;

  final _i49.Queries crowdloan;

  final _i50.Queries stateTrieMigration;

  final _i51.Queries xcmPallet;

  final _i52.Queries messageQueue;

  final _i53.Queries assetRate;

  final _i54.Queries beefy;

  final _i55.Queries mmr;

  final _i56.Queries beefyMmrLeaf;
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

  final _i14.Txs session = _i14.Txs();

  final _i15.Txs grandpa = _i15.Txs();

  final _i17.Txs treasury = _i17.Txs();

  final _i18.Txs convictionVoting = _i18.Txs();

  final _i19.Txs referenda = _i19.Txs();

  final _i20.Txs whitelist = _i20.Txs();

  final _i21.Txs parameters = _i21.Txs();

  final _i22.Txs claims = _i22.Txs();

  final _i23.Txs vesting = _i23.Txs();

  final _i57.Txs utility = _i57.Txs();

  final _i24.Txs proxy = _i24.Txs();

  final _i25.Txs multisig = _i25.Txs();

  final _i26.Txs bounties = _i26.Txs();

  final _i27.Txs childBounties = _i27.Txs();

  final _i28.Txs electionProviderMultiPhase = _i28.Txs();

  final _i29.Txs voterList = _i29.Txs();

  final _i30.Txs nominationPools = _i30.Txs();

  final _i31.Txs fastUnstake = _i31.Txs();

  final _i32.Txs configuration = _i32.Txs();

  final _i35.Txs paraInherent = _i35.Txs();

  final _i37.Txs paras = _i37.Txs();

  final _i38.Txs initializer = _i38.Txs();

  final _i40.Txs hrmp = _i40.Txs();

  final _i42.Txs parasDisputes = _i42.Txs();

  final _i43.Txs parasSlashing = _i43.Txs();

  final _i44.Txs onDemand = _i44.Txs();

  final _i46.Txs registrar = _i46.Txs();

  final _i47.Txs slots = _i47.Txs();

  final _i48.Txs auctions = _i48.Txs();

  final _i49.Txs crowdloan = _i49.Txs();

  final _i58.Txs coretime = _i58.Txs();

  final _i50.Txs stateTrieMigration = _i50.Txs();

  final _i51.Txs xcmPallet = _i51.Txs();

  final _i52.Txs messageQueue = _i52.Txs();

  final _i53.Txs assetRate = _i53.Txs();

  final _i54.Txs beefy = _i54.Txs();
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

  final _i15.Constants grandpa = _i15.Constants();

  final _i17.Constants treasury = _i17.Constants();

  final _i18.Constants convictionVoting = _i18.Constants();

  final _i19.Constants referenda = _i19.Constants();

  final _i22.Constants claims = _i22.Constants();

  final _i23.Constants vesting = _i23.Constants();

  final _i57.Constants utility = _i57.Constants();

  final _i24.Constants proxy = _i24.Constants();

  final _i25.Constants multisig = _i25.Constants();

  final _i26.Constants bounties = _i26.Constants();

  final _i27.Constants childBounties = _i27.Constants();

  final _i28.Constants electionProviderMultiPhase = _i28.Constants();

  final _i29.Constants voterList = _i29.Constants();

  final _i30.Constants nominationPools = _i30.Constants();

  final _i31.Constants fastUnstake = _i31.Constants();

  final _i37.Constants paras = _i37.Constants();

  final _i44.Constants onDemand = _i44.Constants();

  final _i46.Constants registrar = _i46.Constants();

  final _i47.Constants slots = _i47.Constants();

  final _i48.Constants auctions = _i48.Constants();

  final _i49.Constants crowdloan = _i49.Constants();

  final _i58.Constants coretime = _i58.Constants();

  final _i50.Constants stateTrieMigration = _i50.Constants();

  final _i52.Constants messageQueue = _i52.Constants();

  final _i54.Constants beefy = _i54.Constants();
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
    return [
      'CheckMortality',
      'CheckNonce',
      'ChargeTransactionPayment',
      'CheckMetadataHash'
    ];
  }

  List getSignedExtensionExtra() {
    return [
      'CheckSpecVersion',
      'CheckTxVersion',
      'CheckGenesis',
      'CheckMortality',
      'CheckMetadataHash'
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

  _i59.Future connect() async {
    return await _provider.connect();
  }

  _i59.Future disconnect() async {
    return await _provider.disconnect();
  }
}
