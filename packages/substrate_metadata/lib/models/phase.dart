part of models;

enum PhaseType {
  applyExtrinsic,
  finalization,
  initialization;

  String get name {
    switch (this) {
      case applyExtrinsic:
        return 'ApplyExtrinsic';
      case finalization:
        return 'Finalization';
      case initialization:
        return 'Initialization';
    }
  }
}

/// Phase of block execution when event was emitted
class Phase {
  final PhaseType type;
  final int? extrinsicIndex;

  const Phase._(this.type, [this.extrinsicIndex]);

  /// Event emitted during extrinsic application
  const Phase.applyExtrinsic(int index) : this._(PhaseType.applyExtrinsic, index);

  /// Event emitted during block finalization
  const Phase.finalization() : this._(PhaseType.finalization);

  /// Event emitted during block initialization
  const Phase.initialization() : this._(PhaseType.initialization);

  Map<String, dynamic> toJson() => {
        'type': type.name,
        if (extrinsicIndex != null) 'extrinsicIndex': extrinsicIndex,
      };

  @override
  String toString() {
    switch (type) {
      case PhaseType.applyExtrinsic:
        return 'Phase.applyExtrinsic($extrinsicIndex)';
      case PhaseType.finalization:
        return 'Phase.finalization()';
      case PhaseType.initialization:
        return 'Phase.initialization()';
    }
  }
}
