part of 'smart_device_bloc.dart';

abstract class SmartDeviceEvent extends Equatable {
  const SmartDeviceEvent();
}

class GetSmartDevicesEvent extends SmartDeviceEvent {
  const GetSmartDevicesEvent();

  @override
  List<Object> get props => [];
}

class AddSmartDeviceEvent extends SmartDeviceEvent {
  final SmartDevice smartDevice;

  const AddSmartDeviceEvent(this.smartDevice);

  @override
  List<Object> get props => [smartDevice];
}

class UpdateSmartDeviceEvent extends SmartDeviceEvent {
  final SmartDevice smartDevice;

  const UpdateSmartDeviceEvent(this.smartDevice);

  @override
  List<Object> get props => [smartDevice];
}

class DeleteSmartDeviceEvent extends SmartDeviceEvent {
  final SmartDevice smartDevice;

  const DeleteSmartDeviceEvent(this.smartDevice);

  @override
  List<Object> get props => [smartDevice];
}
