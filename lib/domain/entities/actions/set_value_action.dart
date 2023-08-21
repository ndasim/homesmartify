import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/routine_action.dart';

import '../enums/routine_action_type.dart';

class SetValueActionValues extends Equatable {
  final String set;
  final dynamic to;

  const SetValueActionValues({required this.set, required this.to});

  @override
  List<Object?> get props => [set, to];
}

class SetValueAction extends RoutineAction<SetValueActionValues>{
  const SetValueAction({
    required String name,
    required SetValueActionValues values,
  }) : super(name: name, type: RoutineActionType.setValue, values: values);
}