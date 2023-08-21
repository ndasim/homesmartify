import 'package:homesmartify/data/serializers/route_action_serializer.dart';
import 'package:homesmartify/domain/entities/enums/routine_frequency_type.dart';
import 'package:homesmartify/domain/entities/routine.dart';
import 'package:homesmartify/domain/entities/routine_action.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

import '../serializers/smart_device_serializer.dart';

class RoutineModel extends Routine {
  const RoutineModel({
    required String name,
    required SmartDevice device,
    required int startTimeInMinutes,
    required int durationInMinutes,
    required RoutineFrequencyType frequency,
    required List<RoutineAction> actions,
  }) : super(
          name: name,
          device: device,
          startTimeInMinutes: startTimeInMinutes,
          durationInMinutes: durationInMinutes,
          frequency: frequency,
          actions: actions,
        );

  RoutineModel copyWith({
    String? name,
    SmartDevice? device,
    int? startTimeInMinutes,
    int? durationInMinutes,
    RoutineFrequencyType? frequency,
    List<RoutineAction>? actions,
  }) {
    return RoutineModel(
      name: name ?? this.name,
      device: device ?? this.device,
      startTimeInMinutes: startTimeInMinutes ?? this.startTimeInMinutes,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      frequency: frequency ?? this.frequency,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'device': device,
      'startTimeInMinutes': startTimeInMinutes,
      'durationInMinutes': durationInMinutes,
      'frequency': frequency.toString(),
      'actions': actions,
    };
  }

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      name: json['name'],
      device: SmartDeviceSerializer.fromJson(json['device']),
      startTimeInMinutes: json['startTimeInMinutes'],
      durationInMinutes: json['durationInMinutes'],
      frequency: RoutineFrequencyType.values.firstWhere((element) => element.toString() == json['frequency']),
      actions: (json['actions'] as List).map((e) => RoutineActionSerializer.fromJson(e)).toList(),
    );
  }
}
