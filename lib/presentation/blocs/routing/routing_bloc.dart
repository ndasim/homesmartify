import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:homesmartify/presentation/pages/smart_device/smart_device_detail.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

part 'routing_event.dart';
part 'routing_state.dart';

class RoutingBloc extends Bloc<RoutingEvent, RoutingState> {
  RoutingBloc() : super(RoutingInitial()) {
    on<RoutingEvent>((event, emit) {
      if(event is NavigateToSmartDeviceListEvent) {

      } else if(event is NavigateToSmartDeviceDetailEvent) {
        final pageIndexNotifier = ValueNotifier(0);

        WoltModalSheet.show<void>(
          context: event.context,
          pageIndexNotifier: pageIndexNotifier,
          pageListBuilder: (modalSheetContext) {
            return [
              WoltModalSheetPage.withSingleChild(
                child: SmartDeviceDetailPage(smartDevice: event.smartDevice),
              ),
            ];
          },
          onModalDismissedWithBarrierTap: () {
            debugPrint('Closed modal sheet with barrier tap');
            pageIndexNotifier.value = 0;
            Navigator.of(event.context).pop();
          },
          minPageHeight: 0.4,
          maxPageHeight: 0.9,
        );
      } else if(event is NavigateToSmartDeviceUpsertEvent) {

      }
    });
  }
}
