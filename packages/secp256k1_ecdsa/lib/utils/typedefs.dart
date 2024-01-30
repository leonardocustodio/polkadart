part of secp256k1;

typedef HmacFnSync = Uint8List Function(
    Uint8List key, List<Uint8List> messages);
typedef HmacDrbgFunction = Signature Function(
    Uint8List seed, K2SigFunc k2sigFunc);
typedef K2SigFunc = Signature? Function(Uint8List kb);
typedef RandomBytesFunc = Uint8List Function(int length);
