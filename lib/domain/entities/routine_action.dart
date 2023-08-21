import 'package:equatable/equatable.dart';

import 'enums/routine_action_type.dart';

abstract class RoutineAction extends Equatable {
  final String name; // name of the action
  final RoutineActionType type; // type of the action
  final Map<String, dynamic> values; // values of the action

  const RoutineAction({
    required this.name,
    required this.type,
    required this.values,
  });

  @override
  List<Object?> get props => [name, type, values];
}