import '../../../domain/entities/devices/smart_tv.dart';

class SmartTvValuesModel extends SmartTvValues{
  const SmartTvValuesModel({
    required int channel,
    required int volume,
  }) : super(channel: channel, volume: volume);

  factory SmartTvValuesModel.fromJson(Map<String, dynamic> json) {
    return SmartTvValuesModel(
      channel: json['channel'],
      volume: json['volume'],
    );
  }
}

class SmartTvModel extends SmartTv{
  const SmartTvModel({
    required String name,
    required bool status,
    required SmartTvValues values,
  }) : super(name: name, status: status, values: values);

  factory SmartTvModel.fromJson(Map<String, dynamic> json) {
    return SmartTvModel(
      name: json['name'],
      status: json['status'],
      values: SmartTvValuesModel.fromJson(json['values'])
    );
  }
}