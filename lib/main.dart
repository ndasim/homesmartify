import 'package:flutter/material.dart';
import 'package:homesmartify/core/core.dart';
import 'package:homesmartify/data/data_sources/smart_device_local_data_source.dart';
import 'package:homesmartify/data/repositories/smart_device_demo_repository.dart';
import 'package:homesmartify/domain/usecases/smart_device_usecase.dart';
import 'package:homesmartify/presentation/blocs/routing/routing_bloc.dart';
import 'package:homesmartify/presentation/blocs/smart_device/smart_device_bloc.dart';
import 'package:homesmartify/presentation/pages/root_page.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert';

import 'package:secure_shared_preferences/secure_shared_pref.dart';

import 'domain/repositories/smart_device_repository.dart'; // For jsonDecode

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: This block must be handled by the theme manager
  final Map<String, dynamic> themeJson = jsonDecode(await rootBundle.loadString('assets/theme/main_theme.json'));
  final ThemeData theme = ThemeDecoder.decodeThemeData(themeJson)!;

  // Build app dependencies
  await buildAppDependencies();

  runApp(
    HomeSmartify(
      theme: theme,
    ),
  );
}

// -- Dependency injection -- //
Future<void> buildAppDependencies() async{
  // -- Smart Device Layer -- //
  // The bloc
  getIt.registerFactory(() => SmartDeviceBloc(smartDeviceUseCase: getIt()));

  // Use case
  getIt.registerLazySingleton(() => SmartDeviceUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<SmartDeviceRepository>(() => SmartDeviceDemoRepository(getIt()));

  // Data sources
  getIt.registerLazySingleton<SmartDeviceLocalDataSource>(() => SmartDeviceLocalDataSource(getIt()));

  // -- Routine Layer -- //


  // -- Routing Layer -- //
  // The bloc
  getIt.registerFactory(() => RoutingBloc());

  // -- Common Layer -- //
  final sharedPreferences = await SecureSharedPref.getInstance();
  getIt.registerLazySingleton<SecureSharedPref>(() => sharedPreferences);
}

class HomeSmartify extends StatelessWidget {
  final ThemeData theme;

  const HomeSmartify({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Smartify',
      theme: theme,
      home: RootPage(),
    );
  }
}
