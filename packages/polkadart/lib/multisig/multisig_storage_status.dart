part of multisig;

class MultisigStorageStatus extends Equatable {
  final int approvalCount;
  final int threshold;
  final bool isComplete;
  final bool isWaitingForFinalApproval;
  final String depositor;
  final BigInt deposit;
  final TimePoint when;
  final List<String> approvals;
  final bool? hasApproved;
  final bool? canApprove;
  final bool? canCancel;

  const MultisigStorageStatus({
    required this.approvalCount,
    required this.threshold,
    required this.isComplete,
    required this.isWaitingForFinalApproval,
    required this.depositor,
    required this.deposit,
    required this.when,
    required this.approvals,
    this.hasApproved,
    this.canApprove,
    this.canCancel,
  });

  Map<String, dynamic> toJson() => {
    'approvalCount': approvalCount,
    'threshold': threshold,
    'isComplete': isComplete,
    'isWaitingForFinalApproval': isWaitingForFinalApproval,
    'depositor': depositor,
    'deposit': deposit.toString(),
    'when': when.toJson(),
    'approvals': approvals,
    'hasApproved': hasApproved,
    'canApprove': canApprove,
    'canCancel': canCancel,
  };

  @override
  List<Object?> get props => [
    approvalCount,
    threshold,
    isComplete,
    isWaitingForFinalApproval,
    depositor,
    deposit,
    when,
    approvals,
    hasApproved,
    canApprove,
    canCancel,
  ];
}
