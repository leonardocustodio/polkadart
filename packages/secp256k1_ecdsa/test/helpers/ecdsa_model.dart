class Ecdsa {
  List<Valid> valid;
  InValid invalid;
  List<ExtraEntropy> extraEntropy;

  Ecdsa.fromJson(Map<String, dynamic> json)
      : valid = (json['valid'] as List)
            .map((value) => Valid.fromJson(value))
            .toList(),
        invalid = InValid.fromJson(json['invalid']),
        extraEntropy = (json['extraEntropy'] as List)
            .map((value) => ExtraEntropy.fromJson(value))
            .toList();
}

class ExtraEntropy {
  String d;
  String m;
  String signature;
  String extraEntropy0;
  String extraEntropy1;
  String extraEntropyRand;
  String extraEntropyN;
  String extraEntropyMax;

  ExtraEntropy.fromJson(Map<String, dynamic> json)
      : d = json['d'],
        m = json['m'],
        signature = json['signature'],
        extraEntropy0 = json['extraEntropy0'],
        extraEntropy1 = json['extraEntropy1'],
        extraEntropyRand = json['extraEntropyRand'],
        extraEntropyN = json['extraEntropyN'],
        extraEntropyMax = json['extraEntropyMax'];
}

class InValid {
  List<Sign> sign = <Sign>[];
  List<Verify> verify = <Verify>[];

  InValid.fromJson(Map<String, dynamic> json)
      : sign = json['sign'] == null
            ? <Sign>[]
            : (json['sign'] as List)
                .map((value) => Sign.fromJson(value))
                .toList(),
        verify = json['verify'] == null
            ? <Verify>[]
            : (json['verify'] as List)
                .map((value) => Verify.fromJson(value))
                .toList();
}

class Valid {
  String? description;
  String d;
  String m;
  String singature;

  Valid.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        d = json['d'],
        m = json['m'],
        singature = json['signature'];
}

class Sign {
  String description;
  String d;
  String m;
  String exception;

  Sign.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        d = json['d'],
        m = json['m'],
        exception = json['exception'];
}

class Verify {
  String description;
  String q;
  String m;
  String signature;
  String? exception;
  bool? strict;

  Verify.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        q = json['Q'],
        m = json['m'],
        signature = json['signature'],
        strict = json['strict'],
        exception = json['exception'];
}
