part of metadata;

/// Outer enum type references (common interface for V14 and V15)
class OuterEnums {
  final int callType;
  final int eventType;
  final int errorType;

  const OuterEnums({
    required this.callType,
    required this.eventType,
    required this.errorType,
  });
}
