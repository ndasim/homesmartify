import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/devices/smart_bulb.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_types.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

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
    required String name,
    required bool status,
    required SmartBulbValues values,
  }) : super(name: name, status: status, values: values);
  
  factory SmartBulbModel.fromJson(Map<String, dynamic> json) {
    return SmartBulbModel(
      name: json['name'],
      status: json['status'],
      values: SmartBulbValuesModel.fromJson(json['values'])
    );
  }
}
