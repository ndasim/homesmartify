import 'package:flutter/material.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

class SmartDeviceDetailPage extends StatefulWidget {
  final SmartDevice smartDevice;
  const SmartDeviceDetailPage({super.key, required this.smartDevice});

  @override
  State<SmartDeviceDetailPage> createState() => _SmartDeviceDetailPageState();
}

class _SmartDeviceDetailPageState extends State<SmartDeviceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.smartDevice.name,
          style: TextStyle(fontSize: 24.0),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Type: ${widget.smartDevice.type}',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
