import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/consts.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/data/data_sources/local_data_source.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:homesmartify/domain/repositories/smart_device_repository.dart';

class SmartDeviceDemoRepository extends SmartDeviceRepository{
  final LocalDataSource localDataSource;

  SmartDeviceDemoRepository(this.localDataSource);

  @override
  Future<Either<Failure, SmartDevice>> addSmartDevice(SmartDevice<dynamic> smartDevice) {
    return localDataSource.addSmartDevice(smartDevice);
  }

  @override
  Future<Either<Failure, SmartDevice>> deleteSmartDevice(SmartDevice<dynamic> smartDevice) {
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

    if(devices.isLeft()){
      for (SmartDevice device in demoDevices){
        localDataSource.addSmartDevice(device);
      }
    }

    return await localDataSource.getSmartDevices();
  }

  @override
  Future<Either<Failure, SmartDevice>> updateSmartDevice(SmartDevice<dynamic> smartDevice) {
    return localDataSource.updateSmartDevice(smartDevice);
  }
}