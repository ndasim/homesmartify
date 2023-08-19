import 'package:dartz/dartz.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';

abstract class SmartDeviceRepository {
  Future<Either<Failure, SmartDevice>> getSmartDevice(String id);
  Future<Either<Failure, List<SmartDevice>>> getSmartDevices();
  Future<Either<Failure, SmartDevice>> addSmartDevice(SmartDevice smartDevice);
  Future<Either<Failure, SmartDevice>> updateSmartDevice(SmartDevice smartDevice);
  Future<Either<Failure, SmartDevice>> deleteSmartDevice(SmartDevice smartDevice);
}