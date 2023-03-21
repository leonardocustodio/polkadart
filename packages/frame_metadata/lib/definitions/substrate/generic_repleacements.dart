String legacyTypeSimplifier(String type) {
  type = type.trim();

  if (type.startsWith('DefunctVoter<')) {
    return 'DefunctVoter';
  }

  if (type.startsWith('DoubleVoteReport<')) {
    return 'DoubleVoteReport';
  }

  if (type.endsWith('::Proposal>')) {
    return 'Proposal';
  }

  if (type.endsWith('::Signature')) {
    return 'Signature';
  }

  if (type.contains('T as ')) {
    type = type.replaceAll('T as Trait', '');
    type = type.replaceAll('T as Config', '');
    type = type.replaceAll('::', '');
    type = type.replaceAll('<>', '');
    if (type.contains('Box<')) {
      type = type.replaceAll('Box<', '');
      type = type.replaceAll('>', '');
    }
    return type;
  }

  type = type.replaceAll('T::', '');
  type = type.replaceAll('<T>', '');
  type = type.replaceAll('schedule::Period<BlockNumber>', 'Period');
  type = type.replaceAll('schedule::Priority', 'Priority');
  type = type.replaceAll('<Lookup as StaticLookup>::Source', 'Address');

  type = type.replaceAll('EquivocationProof<Header>', 'EquivocationProof');
  type = type.replaceAll(
      'EquivocationProof<Hash, BlockNumber>', 'EquivocationProof');

  type = type.replaceAll('VestingInfo<BalanceOf, BlockNumber>', 'VestingInfo');

  // <BlockNumber> replacements
  type = type.replaceAll('Heartbeat<BlockNumber>', 'Heartbeat');
  type = type.replaceAll('Timepoint<BlockNumber>', 'Timepoint');

  // <BalanceOf> replacements
  type = type.replaceAll('AccountVote<BalanceOf>', 'AccountVote');
  type = type.replaceAll('Judgement<BalanceOf>', 'Judgement');
  type = type.replaceAll('RewardDestination<AccountId>', 'RewardDestination');

  type = type.replaceAll('RawSolution<CompactOf>', 'RawSolution');
  type = type.replaceAll('ReadySolution<AccountId>', 'ReadySolution');

  type = type.replaceAll('IdentityInfo<MaxAdditionalFields>', 'IdentityInfo');
  type = type.replaceAll('Supports<AccountId>', 'Supports');

  type = type.replaceAll('RawSolution<SolutionOf>', 'RawSolution');
  type = type.replaceAll('TaskAddress<BlockNumber>', 'TaskAddress');
  type = type.replaceAll(
      'sp_std::marker::PhantomData<(AccountId, Event)>', 'PhantomData');

  type = type.replaceAll('NewBidder<AccountId>', 'NewBidder');

  if (type.contains('Box<')) {
    type = type.replaceAll('Box<', '');
    type = type.replaceAll('>', '');
  }
  return type;
}
