import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/consts.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/data/data_sources/smart_device_local_data_source.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:homesmartify/domain/repositories/smart_device_repository.dart';

class SmartDeviceDemoRepository extends SmartDeviceRepository{
  final SmartDeviceLocalDataSource localDataSource;

  SmartDeviceDemoRepository(this.localDataSource);

  @override
  Future<Either<Failure, SmartDevice>> addSmartDevice(SmartDevice<dynamic> smartDevice) {
    return localDataSource.addSmartDevice(smartDevice);
  }

  @override
  Future<Either<Failure, List<SmartDevice>>> deleteSmartDevice(SmartDevice<dynamic> smartDevice) {
    return localDataSource.deleteSmartDevice(smartDevice);
  }

  @override
  Future<Either<Failure, SmartDevice>> getSmartDevice(String id) {
    return localDataSource.getSmartDevice(id);
  }

  // For demo purposes, we will add some devices if there are no devices in the local data source
  @override
  Future<Either<Failure, List<SmartDevice>>> getSmartDevices() async{
    Either<Failure, List<SmartDevice>> devices = await localDataSource.getSmartDevices();

    if(devices.toNullable()?.isEmpty ?? true){ // If there are no devices, add the demo devices
      for (SmartDevice<dynamic> device in demoDevices){
        await localDataSource.addSmartDevice(device);
      }
    }

    return await localDataSource.getSmartDevices();
  }

  @override
  Future<Either<Failure, SmartDevice>> updateSmartDevice(SmartDevice<dynamic> smartDevice) {
    return localDataSource.updateSmartDevice(smartDevice);
  }
}