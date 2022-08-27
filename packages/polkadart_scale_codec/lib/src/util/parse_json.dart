import 'dart:typed_data';

import 'package:convert/convert.dart';

dynamic toJSON(dynamic val) {
  if (val == null) {
    return null;
  }

  late dynamic json;

  if (val is BigInt) {
    return val.toString();
  } else if (val is Object) {
    if (val is Uint8List) {
      return hex.encode(val);
    } else if (val is DateTime) {
      return val.toIso8601String();
    } else if ((val as dynamic) is Function &&
        (json = (val as dynamic).toJSON().hashCode) != val.hashCode) {
      // TODO: Check this line for infinite loop
      return toJSON(json);
    } else if (val is Error) {
      json = toJsonObject(val);
      // TODO: Check this line for exception
      if (val.stackTrace != null) {
        json.stackTrace = val.stackTrace;
      } else {
        json.stackTrace = val.toString();
      }
      return json;
    } else if (val is List) {
      return toJsonArray(val);
    } else {
      return toJsonObject(val);
    }
  }
  return val;
}

List<dynamic> toJsonArray(List<dynamic> val) {
  List<dynamic> arr = <dynamic>[]..length = val.length;
  for (var i = 0; i < val.length; i++) {
    arr[i] = toJSON(val[i]);
  }
  return arr;
}

dynamic toJsonObject(dynamic val) {
  var result = <dynamic, dynamic>{};
  for (var key in val) {
    result[key] = toJSON(val[key]);
  }
  return result;
}
