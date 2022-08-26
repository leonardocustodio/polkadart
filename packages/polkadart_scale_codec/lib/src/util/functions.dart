T assertNotNull<T>(T val, {String? msg}) {
  assert(val != null, msg);
  return val;
}
