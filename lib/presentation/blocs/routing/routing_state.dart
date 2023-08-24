part of 'routing_bloc.dart';

abstract class RoutingState extends Equatable {
  const RoutingState();
}

class RoutingInitial extends RoutingState {
  @override
  List<Object> get props => [];
}
