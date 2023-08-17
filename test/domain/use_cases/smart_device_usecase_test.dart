import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homesmartify/core/error/failure.dart';
import 'package:homesmartify/data/repositories/smart_device_repository.dart';
import 'package:homesmartify/domain/entities/devices/smart_bulb.dart';
import 'package:homesmartify/domain/entities/smart_device.dart';
import 'package:homesmartify/domain/usecases/smart_device_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'smart_device_usecase_test.mocks.dart';

@GenerateMocks([SmartDeviceRepository])
void main() {
  late SmartDeviceUseCase usecase;
  late MockSmartDeviceRepository mockSmartDeviceRepository;

  setUp(() {
    mockSmartDeviceRepository = MockSmartDeviceRepository();
    usecase = SmartDeviceUseCase(mockSmartDeviceRepository);
  });

  const String tId = '1';
  const SmartBulb tSmartDevice = SmartBulb(
    name: 'Smart Bulb',
    status: true,
    values: SmartBulbValues(
      color: 0xffffff, hue: 100,
    ),
  );

  final tSmartDevices = [tSmartDevice];

  test(
    '#getSmartDevice returns data when the call to repository is successful',
        () async {
      // arrange
      when(mockSmartDeviceRepository.getSmartDevice(any))
          .thenAnswer((_) async => const Right(tSmartDevice));

      // act
      final result = await usecase.getSmartDevice(tId);

      // assert
      expect(result, const Right(tSmartDevice));
      verify(mockSmartDeviceRepository.getSmartDevice(tId));
      verifyNoMoreInteractions(mockSmartDeviceRepository);
    },
  );

  test(
    '#getSmartDevices returns data when the call to repository is successful',
        () async {
      // arrange
      when(mockSmartDeviceRepository.getSmartDevices())
          .thenAnswer((_) async => Right(tSmartDevices));

      // act
      final result = await usecase.getSmartDevices();

      // assert
      expect(result, Right(tSmartDevices));
      verify(mockSmartDeviceRepository.getSmartDevices());
      verifyNoMoreInteractions(mockSmartDeviceRepository);
    },
  );

  test(
    '#addSmartDevice returns data when the call to repository is successful',
        () async {
      // arrange
      when(mockSmartDeviceRepository.addSmartDevice(any))
          .thenAnswer((_) async => const Right(tSmartDevice));

      // act
      final result = await usecase.addSmartDevice(tSmartDevice);

      // assert
      expect(result, const Right(tSmartDevice));
      verify(mockSmartDeviceRepository.addSmartDevice(tSmartDevice));
      verifyNoMoreInteractions(mockSmartDeviceRepository);
    },
  );
}