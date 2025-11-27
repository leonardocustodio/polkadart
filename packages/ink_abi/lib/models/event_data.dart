import 'package:equatable/equatable.dart';
import 'event_spec.dart';

/// Represents decoded event data with metadata
///
/// Provides comprehensive event information including the event name,
/// decoded data, specification, and version-specific metadata.
///
/// For v4 events, includes the event index.
/// For v5 events, includes the topics list.
class EventData extends Equatable {
  /// Event name/label
  final String name;

  /// Event index (v4 only)
  final int? index;

  /// Decoded event data
  final dynamic data;

  /// Event specification containing type information
  final EventSpec spec;

  /// Topics list (v5 only)
  final List<String>? topics;

  const EventData({
    required this.name,
    this.index,
    required this.data,
    required this.spec,
    this.topics,
  });

  @override
  String toString() {
    return 'EventData(name: $name, index: $index, data: $data)';
  }

  @override
  List<Object?> get props => [name, index, data, spec, topics];
}
