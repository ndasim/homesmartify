import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homesmartify/core/core.dart';
import 'package:homesmartify/presentation/blocs/smart_device/smart_device_bloc.dart';
import 'package:homesmartify/presentation/widgets/smart_device_card.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Devices'),
      ),
      body: BlocProvider<SmartDeviceBloc>(
        create: (BuildContext context) => getIt<SmartDeviceBloc>()..add(const GetSmartDevicesEvent()),
        child: BlocBuilder<SmartDeviceBloc, SmartDeviceState>(
          builder: (BuildContext context, SmartDeviceState state) {
            if (state is EmptyState || state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              // TODO: Build proper error message widget
              return Center(
                child: Text(state.message),
              );
            } else if (state is LoadedListState) {
              if(state.smartDevices.isEmpty){
                return const Center(
                  child: Text('No devices found'),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemCount: state.smartDevices.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SmartDeviceCard(smartDevice: state.smartDevices[index]),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          },
        )
      )
    );
  }
}
