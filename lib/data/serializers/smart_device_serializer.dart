import 'package:homesmartify/domain/entities/smart_device.dart';

import '../../domain/entities/enums/smart_device_type.dart';
import '../models/devices/smart_air_conditioner_model.dart';
import '../models/devices/smart_bulb_model.dart';
import '../models/devices/smart_tv_model.dart';

class SmartDeviceSerializer {
  /// Deserializes the raw smart device data to a smart device object
  static SmartDevice fromJson(Map<String, dynamic> json) {
    SmartDeviceType? type = SmartDeviceType.values.asNameMap()[json["type"]];
    switch (type) {
      case SmartDeviceType.smartBulb:
        return SmartBulbModel.fromJson(json);
      case SmartDeviceType.smartAirConditioner:
        return SmartAirConditionerModel.fromJson(json);
      case SmartDeviceType.smartTv:
        return SmartTvModel.fromJson(json);
      default:
        throw Exception("Unknown smart device type");
    }
  }

  /// Serializes the smart device object to a map
  static Map<String, dynamic> toJson(SmartDevice smartDevice) {
    if(smartDevice is SmartBulbModel){
      return smartDevice.toJson();
    }
    else if(smartDevice is SmartAirConditionerModel){
      return smartDevice.toJson();
    }
    else if(smartDevice is SmartTvModel){
      return smartDevice.toJson();
    }

    return {};
  }
}