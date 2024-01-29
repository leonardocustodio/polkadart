import 'ecdsa_model.dart';
import 'json_model.dart';

class Models {
  static dynamic fromJson(Map<String, dynamic> json, ModelsType type) {
    switch (type) {
      case ModelsType.ecdsa:
        return Ecdsa.fromJson(json);
      case ModelsType.points:
        return PointModel.fromJson(json);
      default:
        throw Exception('Invalid type');
    }
  }
}

enum ModelsType {
  ecdsa,
  points,
}
