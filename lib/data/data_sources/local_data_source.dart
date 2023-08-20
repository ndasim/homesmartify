import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/core.dart';
import 'package:homesmartify/core/error/internal_exception.dart';
import 'package:homesmartify/core/error/no_data_failure.dart';
import 'package:homesmartify/data/models/devices/smart_air_conditioner_model.dart';
import 'package:homesmartify/domain/entities/enums/smart_device_types.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/smart_device.dart';
import '../models/devices/smart_bulb_model.dart';
import '../models/devices/smart_tv.dart';

class LocalDataSource {
  static const String smartDevicesKey = "smart_devices";

  final SecureSharedPref secureSharedPref;

  LocalDataSource(this.secureSharedPref);

  /// Deserializes the raw smart device data to a smart device object
  SmartDevice _deserializeSmartDevice(Map<String, dynamic> rawSmartDevice) {
    SmartDeviceType? type = SmartDeviceType.values.asNameMap()[rawSmartDevice["type"]];
    switch (type) {
      case SmartDeviceType.smartBulb:
        return SmartBulbModel.fromJson(rawSmartDevice);
      case SmartDeviceType.smartAirConditioner:
        return SmartAirConditionerModel.fromJson(rawSmartDevice);
      case SmartDeviceType.smartTv:
        return SmartTvModel.fromJson(rawSmartDevice);
      default:
        throw Exception("Unknown smart device type");
    }
  }

  /// Serializes the smart device object to a map
  Map<String, dynamic> _serializeSmartDevice(SmartDevice smartDevice) {
    if(smartDevice is SmartBulbModel){
      return smartDevice.toJson();
    }
    else if(smartDevice is SmartAirConditionerModel){
      return smartDevice.toJson();
    }
    else if(smartDevice is SmartTvModel){
      return smartDevice.toJson();
    }

    return {

    };
  }

  Future<Either<Failure, List<SmartDevice>>> getSmartDevices() async {
    try {
      // Get the list of devices from the secure shared preferences
      String? data = await secureSharedPref.getString(smartDevicesKey);

      // If there is no data, return a NoDataFailure
      if (data == null) return Future.value(const Left(NoDataFailure()));

      // Decode the list of devices from JSON
      List<Map<String, dynamic>> rawDemoDevices = (jsonDecode(data) as List).cast<Map<String, dynamic>>();

      // Return the list of devices
      return Future.value(
        Right(
          rawDemoDevices.map((value) {
            return _deserializeSmartDevice(value);
          }).toList(),
        ),
      );
    } catch (e, s) {
      return Future.value(Left(InternalException(e, s)));
    }
  }

  Future<Either<Failure, SmartDevice>> addSmartDevice(SmartDevice<dynamic> smartDevice) async {
    try{
      // Get device list
      Either<Failure, List<SmartDevice>> result = await getSmartDevices();

      // If there are no failures, add the new device to the list and save it
      if(result.isRight()){
        // Add the new device to the list
        List<SmartDevice> smartDevices = (result as Right).value..add(smartDevice);

        // Encode the list of devices to JSON
        String data = jsonEncode(smartDevices.map((device) => _serializeSmartDevice(device)).toList());

        // Save the list of devices to the secure shared preferences
        await secureSharedPref.putString(smartDevicesKey, data);

        // Return the new device
        return Right(smartDevice);
      }
      else{ // If there are failures, return the failure
        return Left((result as Left).value);
      }
    } catch(e, s){
      return Left(InternalException(e, s));
    }
  }

  Future<Either<Failure, SmartDevice>> deleteSmartDevice(SmartDevice<dynamic> smartDevice) async {
    try{
      // Get device list
      Either<Failure, List<SmartDevice>> result = await getSmartDevices();

      // If there are no failures, remove the device from the list and save it
      if(result.isRight()){
        // Remove the device from the list
        List<SmartDevice> smartDevices = (result as Right).value..remove(smartDevice);

        // Encode the list of devices to JSON
        String data = jsonEncode(smartDevices.map((device) => _serializeSmartDevice(device)).toList());

        // Save the list of devices to the secure shared preferences
        await secureSharedPref.putString(smartDevicesKey, data);

        // Return the new device
        return Right(smartDevice);
      }
      else{ // If there are failures, return the failure
        return Left((result as Left).value);
      }
    }catch(e, s){
      return Left(InternalException(e, s));
    }
  }

  Future<Either<Failure, SmartDevice>> getSmartDevice(String id) async {
    try{
      // Get device list
      Either<Failure, List<SmartDevice>> result = await getSmartDevices();

      // If there are no failures, return the device with the given id
      if(result.isRight()){
        // Get the device with the given id
        SmartDevice smartDevice = (result as Right).value.firstWhere((element) => element.id == id);

        // Return the device
        return Right(smartDevice);
      }
      else{ // If there are failures, return the failure
        return Left((result as Left).value);
      }
    }catch(e, s){
      return Left(InternalException(e, s));
    }
  }

  Future<Either<Failure, SmartDevice>> updateSmartDevice(SmartDevice<dynamic> smartDevice) async{
    try{
      // Get device list
      Either<Failure, List<SmartDevice>> result = await getSmartDevices();

      // If there are no failures, update the device in the list and save it
      if(result.isRight()){
        // Update the device in the list
        List<SmartDevice> smartDevices = (result as Right).value..removeWhere((element) => element.id == smartDevice.id)..add(smartDevice);

        // Encode the list of devices to JSON
        String data = jsonEncode(smartDevices.map((device) => _serializeSmartDevice(device)).toList());

        // Save the list of devices to the secure shared preferences
        await secureSharedPref.putString(smartDevicesKey, data);

        // Return the device
        return Right(smartDevice);
      }
      else{ // If there are failures, return the failure
        return Left((result as Left).value);
      }
    }catch(e, s){
      return Left(InternalException(e, s));
    }
  }
}
