// Import the necessary packages
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/core/error/internal_exception.dart';
import 'package:homesmartify/core/error/no_data_failure.dart';
import 'package:homesmartify/data/data_sources/local_data_source.dart';
import 'package:homesmartify/data/models/devices/smart_air_conditioner_model.dart';
import 'package:homesmartify/data/models/devices/smart_bulb_model.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:collection/collection.dart';
import '../../core/test_extensions.dart';

import 'local_data_source_test.mocks.dart';

// Generate mocks for SecureSharedPref and http.Client
@GenerateMocks([SecureSharedPref])
void main() {
  // Create an instance of LocalDataSource with mocked dependencies
  late LocalDataSource localDataSource;
  late MockSecureSharedPref mockSecureSharedPref;

  // Define some test data and variables
  late String tData;
  late String tDataRemoved;
  late SmartDevice tSmartDevice;
  late List<SmartDevice> tSmartDevices;

  // Set up the test before each test case
  setUp(() {
    mockSecureSharedPref = MockSecureSharedPref();
    localDataSource = LocalDataSource(mockSecureSharedPref);

    // Define some test data and variables
    tData = '''
    [
        {
            "id": "1",
            "name": "Smart Bulb",
            "type": "smartBulb",
            "status": true,
            "values":
            {
                "color": 50,
                "hue": 100
            }
        },
        {
            "id": "2",
            "name": "Smart AC",
            "type": "smartAirConditioner",
            "status": false,
            "values":
            {
                "temperature": 25,
                "fanSpeed": 3,
                "swing": 1
            }
        }
    ]
    ''';

    tDataRemoved = '''
    [
        {
            "id": "2",
            "name": "Smart AC",
            "type": "smartAirConditioner",
            "status": false,
            "values":
            {
                "temperature": 25,
                "fanSpeed": 3,
                "swing": 1
            }
        }
    ]
    ''';

    tSmartDevice = const SmartBulbModel(
      id: "1",
      name: 'Smart Bulb',
      status: true,
      values: SmartBulbValuesModel(
        color: 50,
        hue: 100,
      ),
    );

    tSmartDevices = [
      const SmartBulbModel(
        id: "1",
        name: 'Smart Bulb',
        status: true,
        values: SmartBulbValuesModel(
          color: 50,
          hue: 100,
        ),
      ),
      const SmartAirConditionerModel(
        id: "2",
        name: 'Smart AC',
        status: false,
        values: SmartAirConditionerValuesModel(
          temperature: 25,
          fanSpeed: 3,
          swing: 1,
        ),
      ),
    ];
  });

  // Define a group of tests for getSmartDevices()
  group('getSmartDevices', () {
    // Define a test case for when there is data in the secure shared preferences
    test(
      '#getSmartDevices should return a list of smart devices when there is data in the secure shared preferences',
      () async {
        // Arrange
        // Stub the getString() method of SecureSharedPref to return the test data
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => tData);

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.getSmartDevices();

        // Assert
        // Verify that the getString() method was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Expect that the result is a Right containing the list of smart devices
        bool isListEqual = const ListEquality().equals(result.getOrElse((l) => []), tSmartDevices);
        expect(isListEqual, equals(true));
      },
    );

    // Define a test case for when there is no data in the secure shared preferences
    test(
      '#getSmartDevices should return a NoDataFailure when there is no data in the secure shared preferences',
      () async {
        // Arrange
        // Stub the getString() method of SecureSharedPref to return null
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => null);

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.getSmartDevices();

        // Assert
        // Verify that the getString() method was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Expect that the result is a Left containing a NoDataFailure
        expect(result, equals(const Left(NoDataFailure())));
      },
    );

    // Define a test case for when an exception occurs while getting data from the secure shared preferences
    test(
      '#getSmartDevices should return an InternalException when an exception occurs while getting data from the secure shared preferences',
      () async {
        // Arrange
        // Stub the getString() method of SecureSharedPref to throw an exception
        when(mockSecureSharedPref.getString(any)).thenThrow(Exception('Some error'));

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.getSmartDevices();

        // Assert
        // Verify that the getString() method was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Expect that the result is a Left containing an InternalException with the error message
        expect(result, equals(Left(InternalException(Exception("Some error")))));
      },
    );
  });

  // Define a group of tests for addSmartDevice()
  group('addSmartDevice', () {
    // Define a test case for when adding a new device succeeds
    test(
      '#addSmartDevice should return the new device when adding it succeeds',
      () async {
        // Arrange
        // Stub the getString() method of SecureSharedPref to return the test data
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => tData);

        // Stub the putString() method of SecureSharedPref to return nothing
        when(mockSecureSharedPref.putString(any, any)).thenAnswer((_) async {});

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.addSmartDevice(tSmartDevice);

        // Assert
        // Verify that the getSmartDevices() method was called once
        verify(localDataSource.getSmartDevices()).called(1);

        // Expect that the result is a Right containing the new device
        expect(result, equals(Right<Failure, SmartDevice>(tSmartDevice)));
      },
    );

    // Define a test case for when adding a new device fails due to no existing devices
    test(
      '#addSmartDevice should return a NoDataFailure when there are no existing devices',
      () async {
        // Arrange
        // Stub the getString() method of SecureSharedPref to return the test data
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => null);

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.addSmartDevice(tSmartDevice);

        // Assert
        // Verify that the getSmartDevices() method was called once
        verify(localDataSource.getSmartDevices()).called(1);

        // Verify that the putString() method was never called
        verifyNever(mockSecureSharedPref.putString(any, any));

        // Expect that the result is a Left containing a NoDataFailure
        expect(result, equals(const Left<Failure, List<SmartDevice>>(NoDataFailure())));
      },
    );

    // Define a test case for when adding a new device fails due to an exception while getting existing devices
    test(
      '#addSmartDevice should return an InternalException when an exception occurs while getting existing devices',
      () async {
        // Arrange
        // Stub the getString() method of LocalDataSource to throw an exception
        when(mockSecureSharedPref.getString(any)).thenThrow(Exception('Some error'));

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.addSmartDevice(tSmartDevice);

        // Assert
        // Verify that the getSmartDevices() method was called once
        verify(localDataSource.getSmartDevices()).called(1);

        // Verify that the putString() method was never called
        verifyNever(mockSecureSharedPref.putString(any, any));

        // Expect that the result is a Left containing an InternalException with the error message
        expect(result, equals(const Left(InternalException('Some error'))));
      },
    );

    // Define a test case for when adding a new device fails due to an exception while saving the new device list
    test(
      '#addSmartDevice should return an InternalException when an exception occurs while saving the new device list',
      () async {
        // Arrange
        // Stub the getSmartDevices() method of LocalDataSource to return a Right containing the list of existing devices
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => tData);

        // Stub the putString() method of SecureSharedPref to throw an exception
        when(mockSecureSharedPref.putString(any, any)).thenThrow(Exception('Some error'));

        // Act
        // Call the function under test and store the result
        final result = await localDataSource.addSmartDevice(tSmartDevice);

        // Assert
        // Verify that the getSmartDevices() method was called once
        verify(localDataSource.getSmartDevices()).called(1);

        // Expect that the result is a Left containing an InternalException with the error message
        expect(result, equals(const Left(InternalException('Some error'))));
      },
    );
  });

  group('deleteSmartDevice', () {
    test(
      'should delete the given smart device from the list and return it when there are no failures',
          () async {
        // Arrange
        // Stub the secure shared preference to return the data when getting the smart devices key
        when(mockSecureSharedPref.getString(any)).thenReturnOneByOne([Future.value(tData), Future.value(tDataRemoved)]);

        // Act
        // Call the deleteSmartDevice function with the smart bulb as the argument
        final result = await localDataSource.deleteSmartDevice(tSmartDevice);

        // Assert
        // Verify that the secure shared preference was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Expect that the result is a right value containing the smart bulb
        expect(result, Right(tSmartDevice));

        // Get the list of smart devices from the local data source
        List<SmartDevice> smartDevices = (await localDataSource.getSmartDevices()).getOrElse((l) => []);

        // Expect that the list of smart devices does not contain the smart bulb anymore
        expect(smartDevices.contains(tSmartDevice), false);
      },
    );

    test(
      'should return a failure when getting the list of smart devices fails',
          () async {
        // Arrange
        // Stub the secure shared preference to throw an exception when getting the smart devices key
        when(mockSecureSharedPref.getString(any))
            .thenThrow(Exception());

        // Act
        // Call the deleteSmartDevice function with any smart device as the argument
        final result = await localDataSource.deleteSmartDevice(tSmartDevice);

        // Assert
        // Verify that the secure shared preference was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a left value containing a failure object
        expect(result, equals(const Left<Failure, List<SmartDevice>>(InternalException("Some error"))));
      },
    );

    test(
      'should return an internal exception when saving the list of smart devices fails',
          () async {
        // Arrange
        // Stub the secure shared preference to return the data when getting the smart devices key
        when(mockSecureSharedPref.getString(any))
            .thenAnswer((_) async => tData);

        // Stub the secure shared preference to throw an exception when putting the smart devices key
        when(mockSecureSharedPref.putString(any, any))
            .thenThrow(Exception());

        // Act
        // Call the deleteSmartDevice function with any smart device as the argument
        final result = await localDataSource.deleteSmartDevice(tSmartDevice);

        // Assert
        // Verify that the secure shared preference was called with the correct key twice (once for getting and once for putting)
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));
        verify(mockSecureSharedPref.putString(LocalDataSource.smartDevicesKey, any));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a left value containing an internal exception object
        expect(result, equals(const Left<Failure, List<SmartDevice>>(InternalException("Some error"))));
      },
    );
  });

  group('getSmartDevice', () {
    test(
      'should return the smart device with the given id when there are no failures',
          () async {
        // Arrange
        // Stub the secure shared preference to return the data when getting the smart devices key
        when(mockSecureSharedPref.getString(any))
            .thenAnswer((_) async => tData);

        // Act
        // Call the getSmartDevice function with the smart bulb id as the argument
        final result = await localDataSource.getSmartDevice(tSmartDevice.id);

        // Assert
        // Verify that the secure shared preference was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a right value containing the smart bulb
        expect(result, Right(tSmartDevice));
      },
    );

    test(
      'should return a failure when getting the list of smart devices fails',
          () async {
        // Arrange
        // Stub the secure shared preference to throw an exception when getting the smart devices key
        when(mockSecureSharedPref.getString(any))
            .thenThrow(Exception());

        // Act
        // Call the getSmartDevice function with any id as the argument
        final result = await localDataSource.getSmartDevice(tSmartDevice.id);

        // Assert
        // Verify that the secure shared preference was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a left value containing a failure object
        expect(result, equals(const Left<Failure, SmartDevice>(InternalException("Some error"))));
      },
    );

    test(
      'should return an internal exception when there is no device with the given id',
          () async {
        // Arrange
        // Stub the secure shared preference to return the data when getting the smart devices key
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => tData);

        // Act
        // Call the getSmartDevice function with an invalid id as the argument
        final result = await localDataSource.getSmartDevice("4");

        // Assert
        // Verify that the secure shared preference was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a left value containing an internal exception object
        expect(result, equals(const Left<Failure, SmartDevice>(InternalException("Some error"))));
      },
    );
  });

  group('updateSmartDevice', () {
    test(
      'should update the given smart device in the list and return it when there are no failures',
          () async {
        // Arrange
        // Stub the secure shared preference to return the data when getting the smart devices key
        when(mockSecureSharedPref.getString(any))
            .thenAnswer((_) async => tData);

        // Act
        // Call the updateSmartDevice function with the smart bulb as the argument and change its brightness to 100
        final result = await localDataSource.updateSmartDevice((tSmartDevice as SmartBulbModel).copyWith(name: "Testo"));

        // Assert
        // Verify that the secure shared preference was called with the correct key twice (once for getting and once for putting)
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));
        verify(mockSecureSharedPref.putString(LocalDataSource.smartDevicesKey, any));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a right value containing the updated smart bulb
        expect((result as Right<Failure, SmartDevice>).value.name, "Testo");
      },
    );

    test(
      'should return a failure when getting the list of smart devices fails',
          () async {
        // Arrange
        // Stub the secure shared preference to throw an exception when getting the smart devices key
        when(mockSecureSharedPref.getString(any))
            .thenThrow(Exception());

        // Act
        // Call the updateSmartDevice function with any smart device as the argument
        final result = await localDataSource.updateSmartDevice(tSmartDevice);

        // Assert
        // Verify that the secure shared preference was called with the correct key
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a left value containing a failure object
        expect(result, equals(const Left<Failure, SmartDevice>(InternalException("Some error"))));
      },
    );

    test(
      'should return an internal exception when saving the list of smart devices fails',
          () async {
        // Arrange
        // Stub the secure shared preference to return the data when getting the smart devices key
        when(mockSecureSharedPref.getString(any)).thenAnswer((_) async => tData);

        // Stub the secure shared preference to throw an exception when putting the smart devices key
        when(mockSecureSharedPref.putString(any, any)).thenThrow(Exception());

        // Act
        // Call the updateSmartDevice function with any smart device as the argument
        final result = await localDataSource.updateSmartDevice(tSmartDevice);

        // Assert
        // Verify that the secure shared preference was called with the correct key twice (once for getting and once for putting)
        verify(mockSecureSharedPref.getString(LocalDataSource.smartDevicesKey));
        verify(mockSecureSharedPref.putString(LocalDataSource.smartDevicesKey, any));

        // Verify that no more interactions happened with the secure shared preference
        verifyNoMoreInteractions(mockSecureSharedPref);

        // Expect that the result is a left value containing an internal exception object
        expect(result, equals(const Left<Failure, SmartDevice>(InternalException("Some error"))));
      },
    );
  });
}
