import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_types.dart';
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

  factory SmartTvValues.fromJson(Map<String, dynamic> json) {
    return SmartTvValues(
      channel: json['channel'],
      volume: json['volume'],
    );
  }
}

class SmartTv extends SmartDevice<SmartTvValues>{
  const SmartTv({
    required String name,
    required bool status,
    required SmartTvValues values,
  }) : super(name: name, type: SmartDeviceType.smartTv, status: status, values: values);

  factory SmartTv.fromJson(Map<String, dynamic> json) {
    return SmartTv(
      name: json['name'],
      status: json['status'],
      values: SmartTvValues.fromJson(json['values'])
    );
  }
}