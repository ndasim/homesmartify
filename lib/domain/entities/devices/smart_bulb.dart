import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_type.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

class SmartBulbValues extends Equatable{
  final int color;
  final int hue;
  
  const SmartBulbValues({
    required this.color,
    required this.hue,
  });
  
  @override
  List<Object?> get props => [color, hue];
}

class SmartBulb extends SmartDevice<SmartBulbValues> {
  const SmartBulb({
    required String id,
    required String name,
    required bool status,
    required SmartBulbValues values,
  }) : super(id: id, name: name, type: SmartDeviceType.smartBulb, status: status, values: values);
}
