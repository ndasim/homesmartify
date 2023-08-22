import 'package:flutter/material.dart';
import 'package:homesmartify/presentation/pages/root_page.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: This block must be handled by the theme manager
  final Map<String, dynamic> themeJson = jsonDecode(await rootBundle.loadString('assets/theme/main_theme.json'));
  final ThemeData theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(
    HomeSmartify(
      theme: theme,
    ),
  );
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
