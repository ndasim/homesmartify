import 'package:homesmartify/data/serializers/route_action_serializer.dart';
import 'package:homesmartify/domain/entities/enums/routine_frequency_type.dart';
import 'package:homesmartify/domain/entities/routine.dart';
import 'package:homesmartify/domain/entities/routine_action.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

import '../serializers/smart_device_serializer.dart';

class RoutineModel extends Routine {
  const RoutineModel({
    required String id,
    required String name,
    required SmartDevice device,
    required int startTimeInMinutes,
    required int durationInMinutes,
    required RoutineFrequencyType frequency,
    required List<RoutineAction> actions,
  }) : super(
          id: id,
          name: name,
          device: device,
          startTimeInMinutes: startTimeInMinutes,
          durationInMinutes: durationInMinutes,
          frequency: frequency,
          actions: actions,
        );

  RoutineModel copyWith({
    String? id,
    String? name,
    SmartDevice? device,
    int? startTimeInMinutes,
    int? durationInMinutes,
    RoutineFrequencyType? frequency,
    List<RoutineAction>? actions,
  }) {
    return RoutineModel(
      id: id ?? this.id,
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
      'id': id,
      'name': name,
      'device': SmartDeviceSerializer.toJson(device),
      'startTimeInMinutes': startTimeInMinutes,
      'durationInMinutes': durationInMinutes,
      'frequency': frequency.name,
      'actions': actions.map((e) => RoutineActionSerializer.toJson(e)).toList()
    };
  }

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    return RoutineModel(
      id: json['id'],
      name: json['name'],
      device: SmartDeviceSerializer.fromJson(json['device']),
      startTimeInMinutes: json['startTimeInMinutes'],
      durationInMinutes: json['durationInMinutes'],
      frequency: RoutineFrequencyType.values.asNameMap()[json["frequency"]] ?? RoutineFrequencyType.never,
      actions: (json['actions'] as List).map((e) => RoutineActionSerializer.fromJson(e)).toList(),
    );
  }
}
