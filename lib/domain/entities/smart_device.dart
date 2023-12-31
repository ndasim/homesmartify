import 'package:equatable/equatable.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_type.dart';

abstract class SmartDevice<T> extends Equatable {
  final String id;
  final String name;
  final SmartDeviceType type;
  final bool status;
  final T values;

  const SmartDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.values,
  });

  @override
  List<Object?> get props => [name, type, status, values];
}