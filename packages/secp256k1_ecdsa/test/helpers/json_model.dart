class PointModel {
  Valid valid;
  InValid invalid;

  PointModel.fromJson(Map<String, dynamic> json)
      : valid = Valid.fromJson(json['valid']),
        invalid = InValid.fromJson(json['invalid']);
}

class InValid {
  List<PrivateAdd> privateAdd = <PrivateAdd>[];
  List<PrivateSub> privateSub = <PrivateSub>[];
  List<PointAdd> pointAdd = <PointAdd>[];
  List<PointAddScalar> pointAddScalar = <PointAddScalar>[];
  List<PointCompress> pointCompress = <PointCompress>[];
  List<PointFromScalar> pointFromScalar = <PointFromScalar>[];
  List<PointMultiply> pointMultiply = <PointMultiply>[];

  InValid.fromJson(Map<String, dynamic> json)
      : pointMultiply = json['pointMultiply'] == null
            ? <PointMultiply>[]
            : (json['pointMultiply'] as List)
                .map((value) => PointMultiply.fromJson(value))
                .toList(),
        pointFromScalar = json['pointFromScalar'] == null
            ? <PointFromScalar>[]
            : (json['pointFromScalar'] as List)
                .map((value) => PointFromScalar.fromJson(value))
                .toList(),
        pointCompress = json['pointCompress'] == null
            ? <PointCompress>[]
            : (json['pointCompress'] as List)
                .map((value) => PointCompress.fromJson(value))
                .toList(),
        pointAddScalar = json['pointAddScalar'] == null
            ? <PointAddScalar>[]
            : (json['pointAddScalar'] as List)
                .map((value) => PointAddScalar.fromJson(value))
                .toList(),
        pointAdd = json['pointAdd'] == null
            ? <PointAdd>[]
            : (json['pointAdd'] as List).map((value) => PointAdd.fromJson(value)).toList(),
        privateAdd = json['privateAdd'] == null
            ? <PrivateAdd>[]
            : (json['privateAdd'] as List).map((value) => PrivateAdd.fromJson(value)).toList(),
        privateSub = json['privateSub'] == null
            ? <PrivateSub>[]
            : (json['privateSub'] as List).map((value) => PrivateSub.fromJson(value)).toList();
}

class Valid {
  List<IsPoint> isPoint = <IsPoint>[];
  List<PointMultiply> pointMultiply = <PointMultiply>[];
  List<PointFromScalar> pointFromScalar = <PointFromScalar>[];
  List<PointAdd> pointAdd = <PointAdd>[];
  List<PointAddScalar> pointAddScalar = <PointAddScalar>[];
  List<PointCompress> pointCompress = <PointCompress>[];
  List<IsPrivate> isPrivate = <IsPrivate>[];
  List<PrivateAdd> privateAdd = <PrivateAdd>[];
  List<PrivateSub> privateSub = <PrivateSub>[];
  List<Add> add = <Add>[];
  List<Negate> negate = <Negate>[];

  Valid.fromJson(Map<String, dynamic> json)
      : pointMultiply = json['pointMultiply'] == null
            ? <PointMultiply>[]
            : (json['pointMultiply'] as List)
                .map((value) => PointMultiply.fromJson(value))
                .toList(),
        pointFromScalar = json['pointFromScalar'] == null
            ? <PointFromScalar>[]
            : (json['pointFromScalar'] as List)
                .map((value) => PointFromScalar.fromJson(value))
                .toList(),
        pointCompress = json['pointCompress'] == null
            ? <PointCompress>[]
            : (json['pointCompress'] as List)
                .map((value) => PointCompress.fromJson(value))
                .toList(),
        pointAdd = json['pointAdd'] == null
            ? <PointAdd>[]
            : (json['pointAdd'] as List).map((value) => PointAdd.fromJson(value)).toList(),
        pointAddScalar = json['pointAddScalar'] == null
            ? <PointAddScalar>[]
            : (json['pointAddScalar'] as List)
                .map((value) => PointAddScalar.fromJson(value))
                .toList(),
        isPoint = json['isPoint'] == null
            ? <IsPoint>[]
            : (json['isPoint'] as List).map((value) => IsPoint.fromJson(value)).toList(),
        isPrivate = json['isPrivate'] == null
            ? <IsPrivate>[]
            : (json['isPrivate'] as List).map((value) => IsPrivate.fromJson(value)).toList(),
        privateAdd = json['privateAdd'] == null
            ? <PrivateAdd>[]
            : (json['privateAdd'] as List).map((value) => PrivateAdd.fromJson(value)).toList(),
        privateSub = json['privateSub'] == null
            ? <PrivateSub>[]
            : (json['privateSub'] as List).map((value) => PrivateSub.fromJson(value)).toList(),
        add = json['add'] == null
            ? <Add>[]
            : (json['add'] as List).map((value) => Add.fromJson(value)).toList(),
        negate = json['negate'] == null
            ? <Negate>[]
            : (json['negate'] as List).map((value) => Negate.fromJson(value)).toList();
}

class PointMultiply {
  String description;
  String p;
  String d;
  String? expected;
  String? exception;

  PointMultiply.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        p = json['P'],
        d = json['d'],
        expected = json['expected'],
        exception = json['exception'];
}

class PointFromScalar {
  String d;
  String? expected;
  String? exception;

  PointFromScalar.fromJson(Map<String, dynamic> json)
      : d = json['d'],
        expected = json['expected'],
        exception = json['exception'];
}

class PointCompress {
  String p;
  bool compress;
  String? expected;
  String? exception;

  PointCompress.fromJson(Map<String, dynamic> json)
      : p = json['P'],
        compress = json['compress'],
        expected = json['expected'],
        exception = json['exception'];
}

class PointAdd {
  String p;
  String q;
  String? expected;
  String? exception;

  PointAdd.fromJson(Map<String, dynamic> json)
      : p = json['P'],
        q = json['Q'],
        expected = json['expected'],
        exception = json['exception'];
}

class PointAddScalar {
  String p;
  String d;
  String? expected;
  String? exception;

  PointAddScalar.fromJson(Map<String, dynamic> json)
      : p = json['P'],
        d = json['d'],
        expected = json['expected'],
        exception = json['exception'];
}

class IsPoint {
  String p;
  bool expected;

  IsPoint.fromJson(Map<String, dynamic> json)
      : p = json['P'],
        expected = json['expected'];
}

class IsPrivate {
  String d;
  bool expected;

  IsPrivate.fromJson(Map<String, dynamic> json)
      : d = json['d'],
        expected = json['expected'];
}

class PrivateAdd {
  String d;
  String tweak;
  String? expected;

  PrivateAdd.fromJson(Map<String, dynamic> json)
      : d = json['d'],
        tweak = json['tweak'],
        expected = json['expected'];
}

class PrivateSub {
  String d;
  String tweak;
  String? expected;

  PrivateSub.fromJson(Map<String, dynamic> json)
      : d = json['d'],
        tweak = json['tweak'],
        expected = json['expected'];
}

class Add {
  String a;
  String b;
  String expected;

  Add.fromJson(Map<String, dynamic> json)
      : a = json['a'],
        b = json['b'],
        expected = json['expected'];
}

class Negate {
  String a;
  String expected;

  Negate.fromJson(Map<String, dynamic> json)
      : a = json['a'],
        expected = json['expected'];
}
