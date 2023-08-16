import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_types.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

class SmartAirConditionerValues extends Equatable{
  final String name;
  final bool status;
  final int temperature;
  final int fanSpeed;
  final int swing;

  const SmartAirConditionerValues({
    required this.name,
    required this.status,
    required this.temperature,
    required this.fanSpeed,
    required this.swing,
  });

  @override
  List<Object?> get props => [name, status, temperature, fanSpeed, swing];
}

class SmartAirConditioner extends SmartDevice<SmartAirConditionerValues>{
  const SmartAirConditioner({
    required String name,
    required bool status,
    required SmartAirConditionerValues values,
  }) : super(name: name, type: SmartDeviceType.smartAirConditioner, status: status, values: values);
}