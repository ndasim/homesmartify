import 'package:homesmartify/domain/entities/actions/set_value_action.dart';

class SetValueActionModel extends SetValueAction{
  const SetValueActionModel({
    required String name,
    required Map<String, dynamic> values,
  }) : super(name: name, values: values);

  SetValueActionModel copyWith({
    String? name,
    Map<String, dynamic>? values,
  }) {
    return SetValueActionModel(
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

  factory SetValueActionModel.fromJson(Map<String, dynamic> json) {
    return SetValueActionModel(
      name: json['name'],
      values: json['values'],
    );
  }
}