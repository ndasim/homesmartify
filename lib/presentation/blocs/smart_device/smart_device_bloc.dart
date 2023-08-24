import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/error/failure.dart';

import '../../../domain/entities/smart_device.dart';
import '../../../domain/usecases/smart_device_usecase.dart';

part 'smart_device_event.dart';
part 'smart_device_state.dart';

class SmartDeviceBloc extends Bloc<SmartDeviceEvent, SmartDeviceState> {
  final SmartDeviceUseCase smartDeviceUseCase;

  SmartDeviceBloc({required this.smartDeviceUseCase}) : super(EmptyState()) {
    on<SmartDeviceEvent>((event, emit) async{
      if(event is GetSmartDevicesEvent) {
        emit(LoadingState());

        // Execute our domain level use case
        Either<Failure, List<SmartDevice>> smartDeviceListEither = await smartDeviceUseCase.getSmartDevices();

        // Convert the Either to a SmartDeviceState
        SmartDeviceState smartDeviceState = smartDeviceListEither.fold(
                (l) => ErrorState(l.message),
                (r) => LoadedListState(r),
        );

        // Emit the SmartDeviceState
        emit(smartDeviceState);
      } else if(event is AddSmartDeviceEvent) {
        emit(LoadingState());

        // Execute our domain level use case
        Either<Failure, SmartDevice> smartDeviceListEither = await smartDeviceUseCase.addSmartDevice(event.smartDevice);

        SmartDeviceState smartDeviceState = smartDeviceListEither.fold(
              (l) => ErrorState(l.message),
              (r) => SmartDeviceDetailState(r),
        );

        emit(smartDeviceState);
      } else if(event is UpdateSmartDeviceEvent) {
        emit(LoadingState());

        // Execute our domain level use case
        Either<Failure, SmartDevice> smartDeviceListEither = await smartDeviceUseCase.updateSmartDevice(event.smartDevice);

        SmartDeviceState smartDeviceState = smartDeviceListEither.fold(
              (l) => ErrorState(l.message),
              (r) => SmartDeviceDetailState(r),
        );

        emit(smartDeviceState);
      } else if(event is DeleteSmartDeviceEvent) {
        emit(LoadingState());

        // Execute our domain level use case
        Either<Failure, List<SmartDevice>> smartDeviceListEither = await smartDeviceUseCase.deleteSmartDevice(event.smartDevice);

        SmartDeviceState smartDeviceState = smartDeviceListEither.fold(
              (l) => ErrorState(l.message),
              (r) => LoadedListState(r),
        );

        emit(smartDeviceState);
      }
    });
  }
}
