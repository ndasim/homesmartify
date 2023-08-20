import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/core/error/no_data_failure.dart';
import 'package:homesmartify/data/data_sources/local_data_source.dart';
import 'package:homesmartify/data/models/devices/smart_bulb_model.dart';
import 'package:homesmartify/data/repositories/smart_device_demo_repository.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../core/test_extensions.dart';
import 'smart_device_demo_repository_test.mocks.dart';

@GenerateMocks([LocalDataSource])
void main() {
  final MockLocalDataSource mockLocalDataSource = MockLocalDataSource();
  final SmartDeviceDemoRepository smartDeviceDemoRepository = SmartDeviceDemoRepository(mockLocalDataSource);

  group('SmartDeviceDemoRepository', () {
    const SmartDevice tSmartDevice = SmartBulbModel(
      id: '9aaa16f6-a8f6-429c-8c5f-5248485b9a16',
      name: 'Smart Bulb 1',
      status: true,
      values: SmartBulbValuesModel(
        color: 0xffffff,
        hue: 100,
      ),
    );

    final List<SmartDevice> tSmartDevices = [tSmartDevice];

    test(
      'addSmartDevice returns correct value',
      () async {
        // Arrange
        when(mockLocalDataSource.addSmartDevice(tSmartDevice)).thenAnswer((_) async => const Right(tSmartDevice));

        // Act
        final Either<Failure, SmartDevice> result = await smartDeviceDemoRepository.addSmartDevice(tSmartDevice);

        // Assert
        expect(result, const Right(tSmartDevice));
        verify(mockLocalDataSource.addSmartDevice(tSmartDevice));
      },
    );

    test(
      'deleteSmartDevice returns correct value',
      () async {
        // Arrange
        when(mockLocalDataSource.deleteSmartDevice(tSmartDevice)).thenAnswer((_) async => const Right(tSmartDevice));

        // Act
        final Either<Failure, SmartDevice> result = await smartDeviceDemoRepository.deleteSmartDevice(tSmartDevice);

        // Assert
        expect(result, const Right(tSmartDevice));
        verify(mockLocalDataSource.deleteSmartDevice(tSmartDevice));
      },
    );

    test(
      'getSmartDevices returns correct value',
      () async {
        // Arrange
        when(mockLocalDataSource.getSmartDevices()).thenAnswer((_) async => Right(tSmartDevices));

        // Act
        final Either<Failure, List<SmartDevice>> result = await smartDeviceDemoRepository.getSmartDevices();

        // Assert
        expect(result, Right(tSmartDevices));
        verify(mockLocalDataSource.getSmartDevices());
      },
    );

    test(
      'getSmartDevices adds demo devices if no devices are found',
      () async {
        // Arrange
        when(mockLocalDataSource.getSmartDevices()).thenReturnOneByOne([Future.value(const Left(NoDataFailure())), Future.value(Right(tSmartDevices))]);
        when(mockLocalDataSource.addSmartDevice(any)).thenAnswer((_) async => const Right(tSmartDevice));

        // Act
        final Either<Failure, List<SmartDevice>> result = await smartDeviceDemoRepository.getSmartDevices();

        // Assert
        expect(result, Right(tSmartDevices));
        verifyInOrder([
          mockLocalDataSource.getSmartDevices(),
          mockLocalDataSource.addSmartDevice(any),
          mockLocalDataSource.getSmartDevices(),
        ]);
      },
    );
  });
}
