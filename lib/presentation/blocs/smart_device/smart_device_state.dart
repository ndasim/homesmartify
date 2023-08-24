part of 'smart_device_bloc.dart';

abstract class SmartDeviceState extends Equatable {
  const SmartDeviceState();
}

class EmptyState extends SmartDeviceState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SmartDeviceState {
  @override
  List<Object> get props => [];
}

class LoadedListState extends SmartDeviceState {
  final List<SmartDevice> smartDevices;

  const LoadedListState(this.smartDevices);

  @override
  List<Object> get props => [smartDevices];
}

class ErrorState extends SmartDeviceState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SmartDeviceDetailState extends SmartDeviceState {
  final SmartDevice smartDevice;

  const SmartDeviceDetailState(this.smartDevice);

  @override
  List<Object> get props => [smartDevice];
}


