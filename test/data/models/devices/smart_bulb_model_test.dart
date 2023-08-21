import 'package:flutter_test/flutter_test.dart';
import 'package:homesmartify/data/models/devices/smart_bulb_model.dart';
import 'package:homesmartify/domain/entities/devices/smart_bulb.dart';

void main() {
  group('SmartBulbValuesModel', () {
    test('should be a subclass of SmartBulbValues entity', () async {
      // Arrange
      const SmartBulbValuesModel tSmartBulbValuesModel = SmartBulbValuesModel(color: 0, hue: 0);

      // act

      // assert
      expect(tSmartBulbValuesModel, isA<SmartBulbValues>());
    });

    test('fromJson should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'color': 0,
        'hue': 0,
      };

      // act
      final SmartBulbValuesModel result = SmartBulbValuesModel.fromJson(jsonMap);

      // assert
      expect(result, isA<SmartBulbValuesModel>());
    });
  });

  group('SmartBulbModel', () {
    test('should be a subclass of SmartBulb entity', () async {
      // arrange
      const SmartBulbValuesModel tSmartBulbValuesModel = SmartBulbValuesModel(color: 0, hue: 0);
      const SmartBulbModel tSmartBulbModel = SmartBulbModel(
        id: '1',
        name: 'Test',
        status: true,
        values: tSmartBulbValuesModel,
      );

      // act

      // assert
      expect(tSmartBulbModel, isA<SmartBulb>());
    });

    test('fromJson should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'name': 'Test',
        'status': true,
        'values': {'color': 0, 'hue': 0}
      };

      // act
      final SmartBulbModel result = SmartBulbModel.fromJson(jsonMap);

      // assert
      expect(result, isA<SmartBulbModel>());
    });
  });
}
