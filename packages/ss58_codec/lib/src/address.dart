import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Address extends Equatable {
  ///
  /// Address [type](https://docs.substrate.io/v3/advanced/ss58/#address-type)
  final int prefix;

  ///
  /// Raw address bytes
  final Uint8List bytes;

  /// constructor to initiate Address Object
  const Address({required this.prefix, required this.bytes});

  @override
  List<Object?> get props => [prefix, bytes];

  @override
  String toString() {
    return 'prefix: $prefix, bytes: $bytes';
  }
}
