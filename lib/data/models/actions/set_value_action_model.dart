import 'package:homesmartify/domain/entities/actions/set_value_action.dart';

class SetValueActionValuesModel extends SetValueActionValues {

  SetValueActionValuesModel({required String set, required dynamic to}) : super(set: set, to: to);

  SetValueActionValuesModel copyWith({
    String? set,
    dynamic to,
  }) {
    return SetValueActionValuesModel(
      set: set ?? this.set,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'set': set,
      'to': to,
    };
  }

  factory SetValueActionValuesModel.fromJson(Map<String, dynamic> json) {
    return SetValueActionValuesModel(
      set: json['set'],
      to: json['to'],
    );
  }
}

class SetValueActionModel extends SetValueAction{
  const SetValueActionModel({
    required String name,
    required SetValueActionValues values,
  }) : super(name: name, values: values);

  SetValueActionModel copyWith({
    String? name,
    SetValueActionValues? values,
  }) {
    return SetValueActionModel(
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

  factory SetValueActionModel.fromJson(Map<String, dynamic> json) {
    return SetValueActionModel(
      name: json['name'],
      values: SetValueActionValuesModel.fromJson(json['values']),
    );
  }
}