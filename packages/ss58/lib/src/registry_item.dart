import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registry_item.g.dart';

/// RegistryItem for storing registry information
///
/// This class can be easily compared for equality.
@JsonSerializable()
class RegistryItem extends Equatable {
  /// The address prefix (ss58 address type).
  ///
  /// Must be unique across registry.
  final int prefix;

  /// Unique identifier for the network that will use this prefix
  ///
  /// No spaces allowed.
  final String network;

  /// Private constructor of RegistryItem Model
  const RegistryItem({required this.prefix, required this.network});

  /// Initialize Registry Item from the Json
  factory RegistryItem.fromJson(Map<String, dynamic> json) => _$RegistryItemFromJson(json);

  /// returns Json of the Registry
  Map<String, dynamic> toJson() => _$RegistryItemToJson(this);

  /// Used to match and calculate hashcode with equality
  @override
  List<Object?> get props => [prefix, network];
}
