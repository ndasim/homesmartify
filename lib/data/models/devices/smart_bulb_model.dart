import 'package:homesmartify/domain/entities/devices/smart_bulb.dart';

class SmartBulbValuesModel extends SmartBulbValues{
  const SmartBulbValuesModel({
    required int color,
    required int hue,
  }) : super(color: color, hue: hue);

  SmartBulbValuesModel copyWith({
    int? color,
    int? hue,
  }) {
    return SmartBulbValuesModel(
      color: color ?? this.color,
      hue: hue ?? this.hue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'hue': hue,
    };
  }

  factory SmartBulbValuesModel.fromJson(Map<String, dynamic> json) {
    return SmartBulbValuesModel(
      color: json['color'],
      hue: json['hue'],
    );
  }
}

class SmartBulbModel extends SmartBulb {
  const SmartBulbModel({
    required String id,
    required String name,
    required bool status,
    required SmartBulbValues values,
  }) : super(id: id, name: name, status: status, values: values);

  SmartBulbModel copyWith({
    String? id,
    String? name,
    bool? status,
    SmartBulbValues? values,
  }) {
    return SmartBulbModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'values': (values as SmartBulbValuesModel).toJson(),
    };
  }

  factory SmartBulbModel.fromJson(Map<String, dynamic> json) {
    return SmartBulbModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      values: SmartBulbValuesModel.fromJson(json['values'])
    );
  }
}
