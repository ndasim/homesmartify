import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/routine_frequency_type.dart';
import 'package:homesmartify/domain/entities/routine_action.dart';
import 'smart_device.dart';

abstract class Routine extends Equatable{
  final String name; // name of the routine
  final SmartDevice device; // device to be controlled by the routine
  final int startTimeInMinutes; // 0 - 1440 (24 hours) defines the start time of the routine in day
  final int durationInMinutes; // 0 - 1440 (24 hours) defines the duration of the routine in day
  final RoutineFrequencyType frequency; // defines the frequency of the routine
  final List<RoutineAction> actions; // defines the actions to be performed by the routine

  const Routine({
    required this.name,
    required this.device,
    required this.startTimeInMinutes,
    required this.durationInMinutes,
    required this.frequency,
    required this.actions,
  });

  @override
  List<Object?> get props => [name, device, startTimeInMinutes, durationInMinutes, frequency, actions];
}