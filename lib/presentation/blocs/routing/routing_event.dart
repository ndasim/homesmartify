part of 'routing_bloc.dart';

abstract class RoutingEvent extends Equatable {
  const RoutingEvent();
}

class NavigateToSmartDeviceListEvent extends RoutingEvent {
  const NavigateToSmartDeviceListEvent();

  @override
  List<Object> get props => [];
}

class NavigateToSmartDeviceDetailEvent extends RoutingEvent {
  final SmartDevice smartDevice;
  final BuildContext context;

  const NavigateToSmartDeviceDetailEvent({required this.context, required this.smartDevice});

  @override
  List<Object> get props => [smartDevice];
}

class NavigateToSmartDeviceUpsertEvent extends RoutingEvent {
  final SmartDevice? smartDevice;

  const NavigateToSmartDeviceUpsertEvent(this.smartDevice);

  @override
  List<Object?> get props => [smartDevice];
}
