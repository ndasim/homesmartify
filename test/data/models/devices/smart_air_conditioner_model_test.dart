import 'package:flutter_test/flutter_test.dart';
import 'package:homesmartify/data/models/devices/smart_air_conditioner_model.dart';

import 'package:homesmartify/domain/entities/devices/smart_air_conditioner.dart';

void main() {
  group('SmartAirConditionerModel', () {
    test('fromJson creates a valid SmartAirConditionerModel object', () async {
      // arrange
      final Map<String, dynamic> json = {
        'id': '1',
        'name': 'Samsung',
        'status': true,
        'values': {
          'name': 'Samsung',
          'status': true,
          'temperature': 24,
          'fanSpeed': 3,
          'swing': 1,
        },
      };

      // act
      final result = SmartAirConditionerModel.fromJson(json);

      // assert
      expect(result, isA<SmartAirConditioner>());
      expect(result.name, equals('Samsung'));
      expect(result.status, equals(true));
      expect(result.values.temperature, equals(24));
      expect(result.values.fanSpeed, equals(3));
      expect(result.values.swing, equals(1));
    });
  });

  group('SmartAirConditionerValuesModel', () {
    test('fromJson creates a valid SmartAirConditionerValuesModel object', () async {
      // arrange
      final Map<String, dynamic> json = {
        'name': 'Samsung',
        'status': true,
        'temperature': 24,
        'fanSpeed': 3,
        'swing': 1,
      };

      // act
      final result = SmartAirConditionerValuesModel.fromJson(json);

      // assert
      expect(result, isA<SmartAirConditionerValues>());
      expect(result.temperature, equals(24));
      expect(result.fanSpeed, equals(3));
      expect(result.swing, equals(1));
    });
  });
}