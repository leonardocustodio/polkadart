part of multisig;

/// Represents a precise point in time on the blockchain.
///
/// A TimePoint uniquely identifies when a multisig transaction was initiated by
/// combining the block height and the extrinsic index within that block. This is
/// required by Substrate's multisig pallet to track and manage pending transactions.
///
/// The timepoint is automatically captured when the first approval is submitted and
/// must be provided with all subsequent approvals to identify the specific transaction.
///
/// Example:
/// ```dart
/// // TimePoint is automatically included in MultisigStorage
/// final storage = await MultisigStorage.fetch(...);
/// if (storage != null) {
///   print('Transaction initiated at block ${storage.when.height}, '
///         'extrinsic ${storage.when.index}');
/// }
/// ```
class TimePoint extends Equatable {
  /// The block height (block number) when the transaction was initiated.
  final int height;

  /// The extrinsic index within the block.
  ///
  /// Multiple extrinsics can exist in a single block, so this index
  /// disambiguates which specific extrinsic initiated the multisig.
  final int index;

  /// Creates a new TimePoint.
  ///
  /// Parameters:
  /// - [height]: The block number
  /// - [index]: The extrinsic index within the block
  const TimePoint({required this.height, required this.index});

  /// Converts this TimePoint to a JSON representation.
  ///
  /// Returns:
  /// A [Map<String, dynamic>] containing the height and index.
  Map<String, dynamic> toJson() => {'height': height, 'index': index};

  /// Creates a TimePoint from a JSON representation.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing height and index
  ///
  /// Returns:
  /// A [TimePoint] instance reconstructed from the JSON data.
  ///
  /// Throws:
  /// - [TypeError] if height or index are not integers
  factory TimePoint.fromJson(final Map<String, dynamic> json) {
    return TimePoint(height: json['height'] as int, index: json['index'] as int);
  }

  @override
  List<Object> get props => [height, index];
}
