import 'package:flutter_test/flutter_test.dart';
import 'package:homesmartify/data/models/devices/smart_tv_model.dart';
import 'package:homesmartify/domain/entities/devices/smart_tv.dart';

void main() {
  group('SmartTvModel', () {
    test('fromJson creates a valid SmartTvModel object', () async {
      // arrange
      final Map<String, dynamic> json = {
        'name': 'Samsung',
        'status': true,
        'values': {'channel': 1, 'volume': 10},
      };

      // act
      final result = SmartTvModel.fromJson(json);

      // assert
      expect(result, isA<SmartTv>());
      expect(result.name, equals('Samsung'));
      expect(result.status, equals(true));
      expect(result.values.channel, equals(1));
      expect(result.values.volume, equals(10));
    });
  });

  group('SmartTvValuesModel', () {
    test('fromJson creates a valid SmartTvValuesModel object', () async {
      // arrange
      final Map<String, dynamic> json = {'channel': 1, 'volume': 10};

      // act
      final result = SmartTvValuesModel.fromJson(json);

      // assert
      expect(result, isA<SmartTvValues>());
      expect(result.channel, equals(1));
      expect(result.volume, equals(10));
    });
  });
}