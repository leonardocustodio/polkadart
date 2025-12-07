part of multisig;

/// Status information for a pending multisig transaction.
///
/// This class provides a comprehensive view of a multisig transaction's current state,
/// including approval progress, depositor information, and signer-specific permissions.
/// It's typically obtained from [MultisigStorage.getStatus] or [MultisigResponse.getStatus].
///
/// Example:
/// ```dart
/// final status = await response.getStatus(provider, signerAddress: bob.address);
/// if (status != null) {
///   print('Progress: ${status.approvalCount}/${status.threshold}');
///   print('Bob has approved: ${status.hasApproved}');
///   print('Bob can approve: ${status.canApprove}');
///   print('Is final approval: ${status.isWaitingForFinalApproval}');
/// }
/// ```
class MultisigStorageStatus extends Equatable {
  /// The number of approvals required to execute the transaction.
  final int threshold;

  /// Whether the transaction has received enough approvals to execute.
  ///
  /// This should normally be false, as transactions are executed immediately
  /// when the threshold is reached.
  final bool isComplete;

  /// Whether the next approval will be the final one that executes the transaction.
  ///
  /// When true, signers should use [Multisig.asMulti] instead of [Multisig.approveAsMulti].
  final bool isWaitingForFinalApproval;

  /// The storage deposit amount (in smallest units) paid by the depositor.
  ///
  /// This will be refunded when the transaction is executed or cancelled.
  final BigInt deposit;

  /// The timepoint when the transaction was initiated.
  ///
  /// Contains the block height and extrinsic index.
  final TimePoint when;

  /// The public key of the depositor who initiated the transaction.
  ///
  /// Only the depositor can cancel the transaction.
  final Uint8List depositor;

  /// List of public keys that have already approved the transaction.
  final List<Uint8List> approvals;

  /// Whether the specified signer has already approved (null if no signer specified).
  final bool? hasApproved;

  /// Whether the specified signer can approve (null if no signer specified).
  ///
  /// False if the signer has already approved or the transaction is complete.
  final bool? canApprove;

  /// Whether the specified signer can cancel (null if no signer specified).
  ///
  /// True only if the signer is the depositor.
  final bool? canCancel;

  /// Creates a MultisigStorageStatus instance.
  ///
  /// Parameters:
  /// - [threshold]: The approval threshold
  /// - [isComplete]: Whether the transaction is complete
  /// - [isWaitingForFinalApproval]: Whether waiting for final approval
  /// - [deposit]: The storage deposit amount
  /// - [when]: The transaction initiation timepoint
  /// - [depositor]: The depositor's public key
  /// - [approvals]: List of approver public keys
  /// - [hasApproved]: Optional flag for signer's approval status
  /// - [canApprove]: Optional flag for signer's approval permission
  /// - [canCancel]: Optional flag for signer's cancellation permission
  const MultisigStorageStatus({
    required this.threshold,
    required this.isComplete,
    required this.isWaitingForFinalApproval,
    required this.deposit,
    required this.when,
    required this.depositor,
    required this.approvals,
    this.hasApproved,
    this.canApprove,
    this.canCancel,
  });

  /// Returns the current number of approvals received.
  ///
  /// This is equivalent to `approvals.length`.
  int get approvalCount => approvals.length;

  /// Converts this status object to a JSON representation.
  ///
  /// Returns:
  /// A [Map<String, dynamic>] containing all status fields.
  Map<String, dynamic> toJson() => {
    'threshold': threshold,
    'isComplete': isComplete,
    'isWaitingForFinalApproval': isWaitingForFinalApproval,
    'deposit': deposit.toString(),
    'when': when.toJson(),
    'depositor': depositor,
    'approvals': approvals,
    'hasApproved': hasApproved,
    'canApprove': canApprove,
    'canCancel': canCancel,
  };

  @override
  List<Object?> get props => [
    threshold,
    isComplete,
    isWaitingForFinalApproval,
    deposit,
    when,
    depositor,
    approvals,
    hasApproved,
    canApprove,
    canCancel,
  ];
}
