import 'package:homesmartify/data/models/devices/smart_air_conditioner_model.dart';
import 'package:homesmartify/data/models/devices/smart_tv_model.dart';

import '../data/models/devices/smart_bulb_model.dart';
import '../domain/entities/devices/smart_air_conditioner.dart';
import '../domain/entities/devices/smart_tv.dart';
import '../domain/entities/routine.dart';
import '../domain/entities/smart_device.dart';

List<SmartDevice> demoDevices = [
  const SmartBulbModel(
    id: '9aaa16f6-a8f6-429c-8c5f-5248485b9a16',
    name: 'Smart Bulb 1',
    status: true,
    values: SmartBulbValuesModel(
      color: 0xffffff, hue: 100,
    ),
  ),
  const SmartBulbModel(
    id: 'ed4d6058-8dac-410a-a003-48545e36e2c1',
    name: 'Smart Bulb 2',
    status: true,
    values: SmartBulbValuesModel(
      color: 0xf5f5f5, hue: 100,
    ),
  ),
  const SmartAirConditionerModel(
    id: '0418843a-1858-45d2-af28-037fa349dfa6',
    name: 'Smart Air Conditioner',
    status: true,
    values: SmartAirConditionerValuesModel(
      temperature: 25,
      fanSpeed: 1,
      swing: 1,
    ),
  ),
  const SmartTvModel(
    id: '9aaa16f6-a8f6-429c-8c5f-5248485b9a18',
    name: 'Smart TV',
    status: true,
    values: SmartTvValuesModel(
      volume: 50,
      channel: 1,
    ),
  )
];

List<Routine> demoRoutines = [];