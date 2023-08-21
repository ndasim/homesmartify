import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/error/internal_exception.dart';
import 'package:homesmartify/core/error/no_data_failure.dart';
import 'package:homesmartify/data/data_sources/routine_local_data_source.dart';
import 'package:homesmartify/data/models/routine_model.dart';
import 'package:homesmartify/data/serializers/routine_model_serializer.dart';
import 'package:homesmartify/domain/entities/routine.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import 'routine_local_data_source_test.mocks.dart';

import 'package:collection/collection.dart';

@GenerateMocks([SecureSharedPref])
void main() {
  late RoutineLocalDataSource dataSource;
  late MockSecureSharedPref mockSecureSharedPref;

  late String routinesKey;
  late RoutineModel routine1;
  late RoutineModel routine2;
  late List<Routine> routines;
  late String routinesJson;

  group("RoutineLocalDataSource", () {
    // Declare the variables late RoutineLocalDataSource dataSource; late MockSecureSharedPref mockSecureSharedPref;
    // Initialize the variables
    setUp(() {
      mockSecureSharedPref = MockSecureSharedPref();
      dataSource = RoutineLocalDataSource(mockSecureSharedPref);

      // Define the test data
      routinesKey = "routines";

      routine1 = RoutineModelSerializer.fromJson({
        "id": "57dd12b2-d0ad-4c28-b9ab-a3210e52c61d",
        "name": "Morning",
        "device": {
          "id": "9aaa16f6-a8f6-429c-8c5f-5248485b9a16",
          "name": "Smart bulb 1",
          "type": "smartBulb",
          "status": true,
          "values": {"hue": 100, "color": 0}
        },
        "startTimeInMinutes": 420,
        "durationInMinutes": 40,
        "frequency": "everyDay",
        "actions": [
          {"type": "turnOn", "name": "Turn On", "values": {"turnOn": true}},
          {"type": "setValue", "name": "Change Color", "values": {"set": "hue", "to": 100}},
        ]
      });

      routine2 = RoutineModelSerializer.fromJson({
        "id": "uuid-v4 id",
        "name": "Night",
        "device": {
          "id": "9aaa16f6-a8f6-429c-8c5f-5248485b9a16",
          "name": "Smart bulb 1",
          "type": "smartBulb",
          "status": true,
          "values": {"hue": 100, "color": 0}
        },
        "startTimeInMinutes": 800,
        "durationInMinutes": 50,
        "frequency": "everyDay",
        "actions": [
          {"type": "turnOn", "name": "Turn On", "values": {"turnOn": false}},
          {"type": "setValue", "name": "Change Color", "values": {"set": "hue", "to": 200}},
        ]
      });

      routines = [routine1, routine2];
      routinesJson = jsonEncode(routines.map((e) => (e as RoutineModel).toJson()).toList());
    });

    // Test the getRoutines method
    group('getRoutines', () {

      // Test the success case
      test('should return a list of routines when there is data in the secure shared preferences', () async {
        // Arrange
        when(mockSecureSharedPref.getString(routinesKey)).thenAnswer((_) async => routinesJson);

        // Act
        final result = await dataSource.getRoutines();

        // Assert
        verify(mockSecureSharedPref.getString(routinesKey));
        bool isEqual = const ListEquality().equals((result as Right).value, routines);
        expect(isEqual, true);
      });

      // Test the failure case
      test('should return a NoDataFailure when there is no data in the secure shared preferences', () async {
        // Arrange
        when(mockSecureSharedPref.getString(routinesKey)).thenAnswer((_) async => null);

        // Act
        final result = await dataSource.getRoutines();

        // Assert
        verify(mockSecureSharedPref.getString(routinesKey));
        expect(result, equals(const Left(NoDataFailure())));
      });

      // Test the exception case
      test('should return an InternalException when an exception occurs', () async {
        // Arrange
        when(mockSecureSharedPref.getString(routinesKey)).thenThrow(Exception());

        // Act
        final result = await dataSource.getRoutines();

        // Assert
        verify(mockSecureSharedPref.getString(routinesKey));
        expect(result, isA<Left>());
        expect((result as Left).value, isA<InternalException>());
      });
    });

    // Test the getRoutine method
    group('getRoutine', () {
      // Test the success case
      test('should return a routine when there is a matching routine in the list', () async {
        // Arrange
        const id = '57dd12b2-d0ad-4c28-b9ab-a3210e52c61d';
        when(mockSecureSharedPref.getString(routinesKey)).thenAnswer((_) async => routinesJson);

        // Act
        final result = await dataSource.getRoutine(id);

        // Assert
        verify(mockSecureSharedPref.getString(routinesKey));
        expect(result, equals(Right(routine1)));
      });

      // Test the failure case
      test('should return a NoDataFailure when there is no matching routine in the list', () async {
        // Arrange
        const id = 'non-existent id';
        when(mockSecureSharedPref.getString(routinesKey)).thenAnswer((_) async => routinesJson);

        // Act
        final result = await dataSource.getRoutine(id);

        // Assert
        verify(mockSecureSharedPref.getString(routinesKey));
        expect(result, equals(const Left(NoDataFailure())));
      });

      // Test the exception case
      test('should return an InternalException when an exception occurs', () async {
        // Arrange
        const id = '57dd12b2-d0ad-4c28-b9ab-a3210e52c61d';
        when(mockSecureSharedPref.getString(routinesKey)).thenThrow(Exception());

        // Act
        final result = await dataSource.getRoutine(id);

        // Assert
        verify(mockSecureSharedPref.getString(routinesKey));
        expect(result, isA<Left>());
        expect((result as Left).value, isA<InternalException>());
      });
    });
  });
}
