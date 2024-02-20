part of multisig;

class FinalApprovalException implements Exception {
  final String message;
  FinalApprovalException(this.message);
}

class OwnerCallException implements Exception {
  final String message;
  OwnerCallException(this.message);
}
