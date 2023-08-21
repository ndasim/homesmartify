import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/routine_action.dart';

import '../enums/routine_action_type.dart';

class TurnOnActionValues extends Equatable{
  final bool turnOn;

  TurnOnActionValues({required this.turnOn});

  @override
  List<Object?> get props => [turnOn];
}

  class TurnOnAction extends RoutineAction<TurnOnActionValues> {
  const TurnOnAction({
    required String name,
    required TurnOnActionValues values,
  }) : super(name: name, type: RoutineActionType.turnOn, values: values);
}
