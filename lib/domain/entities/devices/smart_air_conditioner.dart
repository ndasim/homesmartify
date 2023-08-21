import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_type.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

class SmartAirConditionerValues extends Equatable{
  final int temperature;
  final int fanSpeed;
  final int swing;

  const SmartAirConditionerValues({
    required this.temperature,
    required this.fanSpeed,
    required this.swing,
  });

  @override
  List<Object?> get props => [temperature, fanSpeed, swing];
}

class SmartAirConditioner extends SmartDevice<SmartAirConditionerValues>{
  const SmartAirConditioner({
    required String id,
    required String name,
    required bool status,
    required SmartAirConditionerValues values,
  }) : super(id: id, name: name, type: SmartDeviceType.smartAirConditioner, status: status, values: values);
}