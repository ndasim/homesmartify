import 'package:homesmartify/data/models/routine_model.dart';

import '../../domain/entities/routine.dart';
import 'smart_device_serializer.dart';

class RoutineModelSerializer{
  static RoutineModel fromJson(Map<String, dynamic> json) {
    return RoutineModel.fromJson(json);
  }

  static Map<String, dynamic> toJson(Routine routine) {
    if(routine is RoutineModel){
      return routine.toJson();
    }

    return {};
  }
}