import 'package:homesmartify/domain/entities/actions/turn_on_action.dart';

class TurnOnActionValuesModel extends TurnOnActionValues {
  TurnOnActionValuesModel({required bool turnOn}) : super(turnOn: turnOn);

  TurnOnActionValuesModel copyWith({
    bool? turnOn,
  }) {
    return TurnOnActionValuesModel(
      turnOn: turnOn ?? this.turnOn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'turnOn': turnOn,
    };
  }

  factory TurnOnActionValuesModel.fromJson(Map<String, dynamic> json) {
    return TurnOnActionValuesModel(
      turnOn: json['turnOn'],
    );
  }
}

class TurnOnActionModel extends TurnOnAction{
  const TurnOnActionModel({
    required String name,
    required TurnOnActionValues values,
  }) : super(name: name, values: values);

  TurnOnActionModel copyWith({
    String? name,
    String? type,
    TurnOnActionValues? values,
  }) {
    return TurnOnActionModel(
      name: name ?? this.name,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.name,
      'values': values,
    };
  }

  factory TurnOnActionModel.fromJson(Map<String, dynamic> json) {
    return TurnOnActionModel(
      name: json['name'],
      values: TurnOnActionValuesModel.fromJson(json['values']),
    );
  }
}