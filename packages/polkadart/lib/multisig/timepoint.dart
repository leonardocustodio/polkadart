part of multisig;

/// Represents a point in time on the blockchain
///
/// Used to identify when a multisig transaction was initiated.
class TimePoint extends Equatable {
  /// Block number
  final int height;

  /// Transaction index within the block
  final int index;

  const TimePoint({required this.height, required this.index});

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'height': height,
        'index': index,
      };

  /// Create from JSON
  factory TimePoint.fromJson(final Map<String, dynamic> json) {
    return TimePoint(
      height: json['height'] as int,
      index: json['index'] as int,
    );
  }

  @override
  List<Object> get props => [height, index];
}
