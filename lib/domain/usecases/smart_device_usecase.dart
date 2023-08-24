import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/domain/repositories/smart_device_repository.dart';
import '../entities/smart_device.dart';

class SmartDeviceUseCase {
  final SmartDeviceRepository _smartDeviceRepository;

  SmartDeviceUseCase(this._smartDeviceRepository);

  Future<Either<Failure, SmartDevice>> getSmartDevice(String id) async {
    return await _smartDeviceRepository.getSmartDevice(id);
  }

  Future<Either<Failure, List<SmartDevice>>> getSmartDevices() async {
    return await _smartDeviceRepository.getSmartDevices();
  }

  Future<Either<Failure, SmartDevice>> addSmartDevice(SmartDevice smartDevice) async {
    return await _smartDeviceRepository.addSmartDevice(smartDevice);
  }

  Future<Either<Failure, SmartDevice>> updateSmartDevice(SmartDevice smartDevice) async {
    return await _smartDeviceRepository.updateSmartDevice(smartDevice);
  }

  Future<Either<Failure, List<SmartDevice>>> deleteSmartDevice(SmartDevice smartDevice) async {
    return await _smartDeviceRepository.deleteSmartDevice(smartDevice);
  }
}
