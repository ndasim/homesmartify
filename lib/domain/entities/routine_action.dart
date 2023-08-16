import 'package:equatable/equatable.dart';

class RoutineAction extends Equatable {
  final String name; // name of the action
  final String type; // type of the action
  final Map<String, dynamic> values; // values of the action

  const RoutineAction({
    required this.name,
    required this.type,
    required this.values,
  });

  @override
  List<Object?> get props => [name, type, values];
}