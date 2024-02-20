part of multisig;

class TimePoint {
  final int index;
  final int height;

  const TimePoint({required this.index, required this.height});

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'height': height,
    };
  }
}
