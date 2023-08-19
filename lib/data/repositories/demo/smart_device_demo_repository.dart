import 'package:dartz/dartz.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/data/models/devices/smart_bulb_model.dart';
import 'package:homesmartify/domain/entities/devices/smart_air_conditioner.dart';
import 'package:homesmartify/domain/entities/devices/smart_tv.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:homesmartify/domain/repositories/smart_device_repository.dart';

class SmartDeviceDemoRepository extends SmartDeviceRepository{
  // id's are uuid.v4() generated
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
    const SmartAirConditioner(
      id: '0418843a-1858-45d2-af28-037fa349dfa6',
      name: 'Smart Air Conditioner',
      status: true,
      values: SmartAirConditionerValues(
        temperature: 25,
        fanSpeed: 1,
        swing: 1,
      ),
    ),
    const SmartTv(
      id: '9aaa16f6-a8f6-429c-8c5f-5248485b9a18',
      name: 'Smart TV',
      status: true,
      values: SmartTvValues(
        volume: 50,
        channel: 1,
      ),
    )
  ];

  @override
  Future<Either<Failure, SmartDevice>> addSmartDevice(SmartDevice<dynamic> smartDevice) {
    demoDevices.add(smartDevice);
    return Future.value(Right(smartDevice));
  }

  @override
  Future<Either<Failure, SmartDevice>> deleteSmartDevice(SmartDevice<dynamic> smartDevice) {
    demoDevices.remove(smartDevice);
    return Future.value(Right(smartDevice));
  }

  @override
  Future<Either<Failure, SmartDevice>> getSmartDevice(String id) {
    return Future.value(Right(demoDevices.firstWhere((element) => element.id == id)));
  }

  @override
  Future<Either<Failure, List<SmartDevice>>> getSmartDevices() {
    return Future.value(Right(demoDevices));
  }

  @override
  Future<Either<Failure, SmartDevice>> updateSmartDevice(SmartDevice<dynamic> smartDevice) {
    demoDevices[demoDevices.indexWhere((element) => element.id == smartDevice.id)] = smartDevice;
    return Future.value(Right(smartDevice));
  }
}