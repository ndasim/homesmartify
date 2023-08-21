import 'package:homesmartify/domain/entities/routine_action.dart';

import '../enums/routine_action_type.dart';

class SetValueAction extends RoutineAction{
  const SetValueAction({
    required String name,
    required Map<String, dynamic> values,
  }) : super(name: name, type: RoutineActionType.setValue, values: values);
}