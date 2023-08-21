import 'package:homesmartify/domain/entities/actions/turn_on_action.dart';

class TurnOnActionModel extends TurnOnAction{
  const TurnOnActionModel({
    required String name,
    required Map<String, dynamic> values,
  }) : super(name: name, values: values);

  TurnOnActionModel copyWith({
    String? name,
    String? type,
    Map<String, dynamic>? values,
  }) {
    return TurnOnActionModel(
      name: name ?? this.name,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'values': values,
    };
  }

  factory TurnOnActionModel.fromJson(Map<String, dynamic> json) {
    return TurnOnActionModel(
      name: json['name'],
      values: json['values'],
    );
  }
}