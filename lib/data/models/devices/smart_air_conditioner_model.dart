import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/devices/smart_air_conditioner.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_types.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

class SmartAirConditionerValuesModel extends SmartAirConditionerValues {
  const SmartAirConditionerValuesModel({
    required int temperature,
    required int fanSpeed,
    required int swing,
  }) : super(temperature: temperature, fanSpeed: fanSpeed, swing: swing);

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'fanSpeed': fanSpeed,
      'swing': swing,
    };
  }

  factory SmartAirConditionerValuesModel.fromJson(Map<String, dynamic> json) {
    return SmartAirConditionerValuesModel(
      temperature: json['temperature'],
      fanSpeed: json['fanSpeed'],
      swing: json['swing'],
    );
  }
}

class SmartAirConditionerModel extends SmartAirConditioner {
  const SmartAirConditionerModel({
    required String id,
    required String name,
    required bool status,
    required SmartAirConditionerValuesModel values,
  }) : super(
          id: id,
          name: name,
          status: status,
          values: values,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'values': (values as SmartAirConditionerValuesModel).toJson(),
    };
  }

  factory SmartAirConditionerModel.fromJson(Map<String, dynamic> json) {
    return SmartAirConditionerModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      values: SmartAirConditionerValuesModel.fromJson(json['values']),
    );
  }
}
