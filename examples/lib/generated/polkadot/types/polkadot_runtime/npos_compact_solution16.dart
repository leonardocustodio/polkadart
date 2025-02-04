// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../tuples.dart' as _i2;

class NposCompactSolution16 {
  const NposCompactSolution16({
    required this.votes1,
    required this.votes2,
    required this.votes3,
    required this.votes4,
    required this.votes5,
    required this.votes6,
    required this.votes7,
    required this.votes8,
    required this.votes9,
    required this.votes10,
    required this.votes11,
    required this.votes12,
    required this.votes13,
    required this.votes14,
    required this.votes15,
    required this.votes16,
  });

  factory NposCompactSolution16.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final List<_i2.Tuple2<BigInt, BigInt>> votes1;

  final List<_i2.Tuple3<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>> votes2;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes3;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes4;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes5;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes6;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes7;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes8;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes9;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes10;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes11;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes12;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes13;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes14;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes15;

  final List<_i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>
      votes16;

  static const $NposCompactSolution16Codec codec =
      $NposCompactSolution16Codec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<List<dynamic>>> toJson() => {
        'votes1': votes1
            .map((value) => [
                  value.value0,
                  value.value1,
                ])
            .toList(),
        'votes2': votes2
            .map((value) => [
                  value.value0,
                  [
                    value.value1.value0,
                    value.value1.value1,
                  ],
                  value.value2,
                ])
            .toList(),
        'votes3': votes3
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes4': votes4
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes5': votes5
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes6': votes6
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes7': votes7
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes8': votes8
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes9': votes9
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes10': votes10
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes11': votes11
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes12': votes12
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes13': votes13
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes14': votes14
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes15': votes15
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
        'votes16': votes16
            .map((value) => [
                  value.value0,
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1,
                          ])
                      .toList(),
                  value.value2,
                ])
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NposCompactSolution16 &&
          _i4.listsEqual(
            other.votes1,
            votes1,
          ) &&
          _i4.listsEqual(
            other.votes2,
            votes2,
          ) &&
          _i4.listsEqual(
            other.votes3,
            votes3,
          ) &&
          _i4.listsEqual(
            other.votes4,
            votes4,
          ) &&
          _i4.listsEqual(
            other.votes5,
            votes5,
          ) &&
          _i4.listsEqual(
            other.votes6,
            votes6,
          ) &&
          _i4.listsEqual(
            other.votes7,
            votes7,
          ) &&
          _i4.listsEqual(
            other.votes8,
            votes8,
          ) &&
          _i4.listsEqual(
            other.votes9,
            votes9,
          ) &&
          _i4.listsEqual(
            other.votes10,
            votes10,
          ) &&
          _i4.listsEqual(
            other.votes11,
            votes11,
          ) &&
          _i4.listsEqual(
            other.votes12,
            votes12,
          ) &&
          _i4.listsEqual(
            other.votes13,
            votes13,
          ) &&
          _i4.listsEqual(
            other.votes14,
            votes14,
          ) &&
          _i4.listsEqual(
            other.votes15,
            votes15,
          ) &&
          _i4.listsEqual(
            other.votes16,
            votes16,
          );

  @override
  int get hashCode => Object.hash(
        votes1,
        votes2,
        votes3,
        votes4,
        votes5,
        votes6,
        votes7,
        votes8,
        votes9,
        votes10,
        votes11,
        votes12,
        votes13,
        votes14,
        votes15,
        votes16,
      );
}

class $NposCompactSolution16Codec with _i1.Codec<NposCompactSolution16> {
  const $NposCompactSolution16Codec();

  @override
  void encodeTo(
    NposCompactSolution16 obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes1,
      output,
    );
    const _i1
        .SequenceCodec<_i2.Tuple3<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>>(
        _i2.Tuple3Codec<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i2.Tuple2Codec<BigInt, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.CompactBigIntCodec.codec,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes2,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        2,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes3,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        3,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes4,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        4,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes5,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        5,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes6,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        6,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes7,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        7,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes8,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        8,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes9,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        9,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes10,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        10,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes11,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        11,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes12,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        12,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes13,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        13,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes14,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        14,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes15,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
        _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
      _i1.CompactBigIntCodec.codec,
      _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        15,
      ),
      _i1.CompactBigIntCodec.codec,
    )).encodeTo(
      obj.votes16,
      output,
    );
  }

  @override
  NposCompactSolution16 decode(_i1.Input input) {
    return NposCompactSolution16(
      votes1: const _i1.SequenceCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes2: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>>(
          _i2.Tuple3Codec<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes3: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          2,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes4: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          3,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes5: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          4,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes6: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          5,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes7: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          6,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes8: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          7,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes9: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          8,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes10: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          9,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes11: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          10,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes12: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          11,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes13: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          12,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes14: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          13,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes15: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          14,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
      votes16: const _i1.SequenceCodec<
              _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
          _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
        _i1.CompactBigIntCodec.codec,
        _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          15,
        ),
        _i1.CompactBigIntCodec.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(NposCompactSolution16 obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes1);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>>(
            _i2.Tuple3Codec<BigInt, _i2.Tuple2<BigInt, BigInt>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i2.Tuple2Codec<BigInt, BigInt>(
            _i1.CompactBigIntCodec.codec,
            _i1.CompactBigIntCodec.codec,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes2);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            2,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes3);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            3,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes4);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            4,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes5);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            5,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes6);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            6,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes7);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            7,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes8);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            8,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes9);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            9,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes10);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            10,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes11);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            11,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes12);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            12,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes13);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            13,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes14);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            14,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes15);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>>(
            _i2.Tuple3Codec<BigInt, List<_i2.Tuple2<BigInt, BigInt>>, BigInt>(
          _i1.CompactBigIntCodec.codec,
          _i1.ArrayCodec<_i2.Tuple2<BigInt, BigInt>>(
            _i2.Tuple2Codec<BigInt, BigInt>(
              _i1.CompactBigIntCodec.codec,
              _i1.CompactBigIntCodec.codec,
            ),
            15,
          ),
          _i1.CompactBigIntCodec.codec,
        )).sizeHint(obj.votes16);
    return size;
  }
}
