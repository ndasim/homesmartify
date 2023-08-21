import '../../../domain/entities/devices/smart_tv.dart';

class SmartTvValuesModel extends SmartTvValues{
  const SmartTvValuesModel({
    required int channel,
    required int volume,
  }) : super(channel: channel, volume: volume);

  SmartTvValuesModel copyWith({
    int? channel,
    int? volume,
  }) {
    return SmartTvValuesModel(
      channel: channel ?? this.channel,
      volume: volume ?? this.volume,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'volume': volume,
    };
  }

  factory SmartTvValuesModel.fromJson(Map<String, dynamic> json) {
    return SmartTvValuesModel(
      channel: json['channel'],
      volume: json['volume'],
    );
  }
}

class SmartTvModel extends SmartTv{
  const SmartTvModel({
    required String id,
    required String name,
    required bool status,
    required SmartTvValues values,
  }) : super(id: id, name: name, status: status, values: values);

  SmartTvModel copyWith({
    String? id,
    String? name,
    bool? status,
    SmartTvValues? values,
  }) {
    return SmartTvModel(
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
      'type': type.name,
      'status': status,
      'values': (values as SmartTvValuesModel).toJson(),
    };
  }

  factory SmartTvModel.fromJson(Map<String, dynamic> json) {
    return SmartTvModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      values: SmartTvValuesModel.fromJson(json['values'])
    );
  }
}