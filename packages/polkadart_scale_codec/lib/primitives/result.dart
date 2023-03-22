part of primitives;

class ResultCodec<R, E> with Codec<Result<R, E>> {
  final Codec<R> okCodec;
  final Codec<E> errCodec;

  const ResultCodec(this.okCodec, this.errCodec);

  @override
  void encodeTo(Result<R, E> value, Output output) {
    if (value.isOk) {
      output.pushByte(0);
      okCodec.encodeTo(value.okValue as R, output);
    } else {
      output.pushByte(1);
      errCodec.encodeTo(value.errValue as E, output);
    }
  }

  @override
  Result<R, E> decode(Input input) {
    final index = input.read();
    switch (index) {
      case 0:
        return Result.ok(okCodec.decode(input));
      case 1:
        return Result.err(errCodec.decode(input));
      default:
        throw Exception('Invalid index for Result: $index');
    }
  }

  @override
  int sizeHint(Result<R, E> value) {
    if (value.isOk) {
      return 1 + okCodec.sizeHint(value.okValue as R);
    }
    return 1 + errCodec.sizeHint(value.errValue as E);
  }
}

class Result<R, E> {
  final R? okValue;
  final E? errValue;

  final bool _isOk; // Workaround for Result<int?, String?>.ok(null)

  const Result.ok(this.okValue)
      : errValue = null,
        _isOk = true;
  const Result.err(this.errValue)
      : okValue = null,
        _isOk = false;

  bool get isOk => _isOk;
  bool get isErr => !_isOk;

  Map<String, dynamic> toJson() {
    if (_isOk) {
      return {'Ok': okValue};
    }
    return {'Err': errValue};
  }

  @override
  String toString() {
    if (_isOk) {
      return 'Result.Ok($okValue)';
    }
    return 'Result.Err($okValue)';
  }
}
