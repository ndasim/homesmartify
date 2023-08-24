import 'package:flutter/material.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_type.dart';

import '../../domain/entities/smart_device.dart';

class SmartDeviceCard extends StatefulWidget {
  final SmartDevice smartDevice;

  const SmartDeviceCard({super.key, required this.smartDevice});

  @override
  State<SmartDeviceCard> createState() => _SmartDeviceCardState();
}

class _SmartDeviceCardState extends State<SmartDeviceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(widget.smartDevice.name),
        subtitle: Text(metadataOfDeviceType()),
        onTap: () {
          Navigator.pushNamed(context, '/device', arguments: widget.smartDevice);
        },
        trailing: Image.asset(
          assetOfDeviceType(widget.smartDevice.type),
          width: 32.0,
          height: 32.0,
        )
      ),
    );
  }

  String metadataOfDeviceType() {
    switch (widget.smartDevice.type) {
      case SmartDeviceType.smartTv:
        return 'Channel: ${widget.smartDevice.values.channel}, Volume: ${widget.smartDevice.values.volume}';
      case SmartDeviceType.smartAirConditioner:
        return 'Temperature: ${widget.smartDevice.values.temperature}, Fan Speed: ${widget.smartDevice.values.fanSpeed}';
      default:
        return 'Brightness: ${widget.smartDevice.values.brightness}, Color: ${widget.smartDevice.values.color}';
    }
  }

  String assetOfDeviceType(SmartDeviceType deviceType) {
    switch (deviceType) {
      case SmartDeviceType.smartTv:
        return 'assets/icons/ic_smart_tv.png';
      case SmartDeviceType.smartAirConditioner:
        return 'assets/icons/ic_smart_airconditioner.png';
      default:
        return 'assets/icons/ic_smart_bulb.png';
    }
  }
}
