import 'package:homesmartify/domain/entities/devices/smart_bulb.dart';

class SmartBulbValuesModel extends SmartBulbValues{
  const SmartBulbValuesModel({
    required int color,
    required int hue,
  }) : super(color: color, hue: hue);
  
  @override
  List<Object?> get props => [color, hue];

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
  
  factory SmartBulbModel.fromJson(Map<String, dynamic> json) {
    return SmartBulbModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      values: SmartBulbValuesModel.fromJson(json['values'])
    );
  }
}
