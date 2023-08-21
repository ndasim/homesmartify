import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_type.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

class SmartTvValues extends Equatable{
  final int channel;
  final int volume;

  const SmartTvValues({
    required this.channel,
    required this.volume,
  });

  @override
  List<Object?> get props => [channel, volume];
}

class SmartTv extends SmartDevice<SmartTvValues>{
  const SmartTv({
    required String id,
    required String name,
    required bool status,
    required SmartTvValues values,
  }) : super(id: id, name: name, type: SmartDeviceType.smartTv, status: status, values: values);
}