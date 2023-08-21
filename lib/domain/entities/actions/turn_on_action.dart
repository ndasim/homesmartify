import 'package:homesmartify/domain/entities/routine_action.dart';

import '../enums/routine_action_type.dart';

class TurnOnAction extends RoutineAction {
  const TurnOnAction({
    required String name,
    required Map<String, dynamic> values,
  }) : super(name: name, type: RoutineActionType.turnOn, values: values);
}
