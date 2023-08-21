import 'package:homesmartify/data/models/actions/set_value_action_model.dart';

import '../../domain/entities/enums/routine_action_type.dart';
import '../../domain/entities/routine_action.dart';
import '../models/actions/turn_on_action_model.dart';

class RoutineActionSerializer{
  /// Deserializes a RoutineAction object from a JSON object
  static RoutineAction fromJson(Map<String, dynamic> json) {
    RoutineActionType? type = RoutineActionType.values.asNameMap()[json["type"]];
    switch (type) {
      case RoutineActionType.turnOn:
        return TurnOnActionModel.fromJson(json);
      case RoutineActionType.setValue:
        return SetValueActionModel.fromJson(json);
      default:
        throw Exception("Unknown routine action type");
    }
  }

  /// Serializes a RoutineAction object to a JSON object
  static Map<String, dynamic> toJson(RoutineAction routineAction) {
    if(routineAction is TurnOnActionModel){
      return routineAction.toJson();
    }
    else if(routineAction is SetValueActionModel){
      return routineAction.toJson();
    }

    return {};
  }
}