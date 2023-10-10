// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// The sender tried to open a channel to themselves.
  openHrmpChannelToSelf('OpenHrmpChannelToSelf', 0),

  /// The recipient is not a valid para.
  openHrmpChannelInvalidRecipient('OpenHrmpChannelInvalidRecipient', 1),

  /// The requested capacity is zero.
  openHrmpChannelZeroCapacity('OpenHrmpChannelZeroCapacity', 2),

  /// The requested capacity exceeds the global limit.
  openHrmpChannelCapacityExceedsLimit('OpenHrmpChannelCapacityExceedsLimit', 3),

  /// The requested maximum message size is 0.
  openHrmpChannelZeroMessageSize('OpenHrmpChannelZeroMessageSize', 4),

  /// The open request requested the message size that exceeds the global limit.
  openHrmpChannelMessageSizeExceedsLimit(
      'OpenHrmpChannelMessageSizeExceedsLimit', 5),

  /// The channel already exists
  openHrmpChannelAlreadyExists('OpenHrmpChannelAlreadyExists', 6),

  /// There is already a request to open the same channel.
  openHrmpChannelAlreadyRequested('OpenHrmpChannelAlreadyRequested', 7),

  /// The sender already has the maximum number of allowed outbound channels.
  openHrmpChannelLimitExceeded('OpenHrmpChannelLimitExceeded', 8),

  /// The channel from the sender to the origin doesn't exist.
  acceptHrmpChannelDoesntExist('AcceptHrmpChannelDoesntExist', 9),

  /// The channel is already confirmed.
  acceptHrmpChannelAlreadyConfirmed('AcceptHrmpChannelAlreadyConfirmed', 10),

  /// The recipient already has the maximum number of allowed inbound channels.
  acceptHrmpChannelLimitExceeded('AcceptHrmpChannelLimitExceeded', 11),

  /// The origin tries to close a channel where it is neither the sender nor the recipient.
  closeHrmpChannelUnauthorized('CloseHrmpChannelUnauthorized', 12),

  /// The channel to be closed doesn't exist.
  closeHrmpChannelDoesntExist('CloseHrmpChannelDoesntExist', 13),

  /// The channel close request is already requested.
  closeHrmpChannelAlreadyUnderway('CloseHrmpChannelAlreadyUnderway', 14),

  /// Canceling is requested by neither the sender nor recipient of the open channel request.
  cancelHrmpOpenChannelUnauthorized('CancelHrmpOpenChannelUnauthorized', 15),

  /// The open request doesn't exist.
  openHrmpChannelDoesntExist('OpenHrmpChannelDoesntExist', 16),

  /// Cannot cancel an HRMP open channel request because it is already confirmed.
  openHrmpChannelAlreadyConfirmed('OpenHrmpChannelAlreadyConfirmed', 17),

  /// The provided witness data is wrong.
  wrongWitness('WrongWitness', 18);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.openHrmpChannelToSelf;
      case 1:
        return Error.openHrmpChannelInvalidRecipient;
      case 2:
        return Error.openHrmpChannelZeroCapacity;
      case 3:
        return Error.openHrmpChannelCapacityExceedsLimit;
      case 4:
        return Error.openHrmpChannelZeroMessageSize;
      case 5:
        return Error.openHrmpChannelMessageSizeExceedsLimit;
      case 6:
        return Error.openHrmpChannelAlreadyExists;
      case 7:
        return Error.openHrmpChannelAlreadyRequested;
      case 8:
        return Error.openHrmpChannelLimitExceeded;
      case 9:
        return Error.acceptHrmpChannelDoesntExist;
      case 10:
        return Error.acceptHrmpChannelAlreadyConfirmed;
      case 11:
        return Error.acceptHrmpChannelLimitExceeded;
      case 12:
        return Error.closeHrmpChannelUnauthorized;
      case 13:
        return Error.closeHrmpChannelDoesntExist;
      case 14:
        return Error.closeHrmpChannelAlreadyUnderway;
      case 15:
        return Error.cancelHrmpOpenChannelUnauthorized;
      case 16:
        return Error.openHrmpChannelDoesntExist;
      case 17:
        return Error.openHrmpChannelAlreadyConfirmed;
      case 18:
        return Error.wrongWitness;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
